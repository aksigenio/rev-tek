# Deploy do landing page

## 1) Publicar no Vercel (recomendado)

1. Abra [https://vercel.com](https://vercel.com) e faça login.
2. Clique em **Add New... > Project**.
3. Em **Import Git Repository**, ligue o GitHub/GitLab/Bitbucket (se ainda não ligou).
4. Suba esta pasta para um repositório (ficheiros principais: `index.html`, `styles.css`, `script.js`, `assets/logo.png`, `vercel.json`).
5. Selecione o repositório no Vercel e clique em **Import**.
6. Framework preset: **Other** (ou Detected as Static).
7. Build command: deixe vazio.
8. Output directory: deixe vazio.
9. Clique em **Deploy**.

Depois do deploy, recebe uma URL tipo:
`https://rev-tek-xxxxx.vercel.app`

## 2) Ligar domínio personalizado

No Vercel:
1. Abra o projeto.
2. Vá a **Settings > Domains**.
3. Clique em **Add Domain** e escreva o domínio (ex: `rev-tek.pt`).
4. O Vercel mostrará os registos DNS necessários.

Regra habitual:
- Para domínio raiz (`rev-tek.pt`): registo **A** para `76.76.21.21`
- Para `www.rev-tek.pt`: registo **CNAME** para `cname.vercel-dns.com`

Depois volte ao Vercel e confirme. Em poucos minutos (às vezes até 24h) o SSL ativa automaticamente.

## 3) Onde comprar domínio (Portugal/Espanha)

Opções populares:
- Cloudflare Registrar
- Namecheap
- OVHcloud
- GoDaddy

Sugestões:
- Compre variações: `.pt`, `.com`, `.es` (se disponível).
- Ative WHOIS privacy (quando aplicável).
- Use um email de empresa para registo.

## 4) Passos rápidos de compra + ligação

1. Comprar domínio no registrador.
2. Copiar nameservers ou configurar DNS zone.
3. No Vercel, adicionar domínio.
4. No registrador, criar os registos DNS pedidos pelo Vercel.
5. Aguardar propagação DNS.
6. Testar `https://teudominio` e `https://www.teudominio`.

## 5) Nota sobre formulário de orçamento

O formulário atual usa `formsubmit.co` e envia para `technipiso@gmail.com`.
No primeiro envio, pode ser necessário confirmar o email de destino.

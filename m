Return-Path: <linux-hyperv+bounces-9481-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lWl2Cg/auGnskAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9481-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 05:35:27 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A68A2A3C0B
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 05:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3CCF230461CE
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 04:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A873331A61;
	Tue, 17 Mar 2026 04:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dcHz9jWS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EED1F1513
	for <linux-hyperv@vger.kernel.org>; Tue, 17 Mar 2026 04:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773721851; cv=pass; b=i7wxVkOlHd9xq4kPFaDQI/hIQkl7sm7zQlHKJYR/Z1PJom8gs0sdkMC8q+H010/w+CsCTdgB/UeIonufLtG/Y5NBy+SGHfhieBPRAWxx+DfisQeWqzNHvNGtKs50wmaQu2jwtAgJV2H6vfNb/m3PGAA5G9bs3YOLrwg8ChP6nNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773721851; c=relaxed/simple;
	bh=+qEdsUsTBQ5PdU99AN+GVBCS7vF9AHbvt2iuwIsGSck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQGgXdx4CDFWeW0TwAjOAP1d9t2TV+UZFHhhPaFDamCAvxO9wQTTBExiBdERtBd/yPSrcFy8ZmMUzkJ8mZH9WrkNMUoh74ammzGS976siffzAPDpj6B7Vol4oyT+BAwcK2RG3Vzrg1e1rO5m67WJkYQSgmKKpBhGmKX5+SI+PAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dcHz9jWS; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50906a98ffeso374401cf.0
        for <linux-hyperv@vger.kernel.org>; Mon, 16 Mar 2026 21:30:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773721848; cv=none;
        d=google.com; s=arc-20240605;
        b=GO52ZEO9ukA0bAuZEHBNwBFpE5B+k+TRdzbSdX/6y6hsSvaQJ4wnbTuIuXr0dzD2sD
         ZOqP8EQcNnZXEdKaEXHEhBmmvSMj65UU86/w9oqWb+rE1Ux7AR09xri1sqxsez40y8lA
         bmhxdWbKsfEYJfcpiFovuJIvJhkX5YRm+fR6yh4b0JajAmQ95WjEx4yBokcukJXY3hqT
         zhb24WxtwFUh10g/4CoyWHs+ZA2Bfwg7cxyQ/OVkWwGDBDxV39FSDoBzvFW0HxaliopQ
         vnHr9ubH3ghSLh/BiM9T55k4B6sqO2Y4QpJmxtptfMisc0CRGUdXPaDu8H7/ir43bE1Y
         OIyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pFQPhmx+ISxO6Fn3xc13MwW50zT+1NZPXlLC27SUdek=;
        fh=SXlQhzv3C10qFf+NBd6ucmXIIyzp6kRyCGjA9Z1ZkfU=;
        b=WUBDh7pPw6moRkcWjoTXK1uoHgU5Sy55J/sEB5NgY1KxPlLmqQ+Oum65FTbKvTC9mb
         offPB55YWKlVWOvOPohekWzyzTL8GSv0l4FluwU9xNQ7jSjQCndS0dXiWP0e5zkCw/OU
         O+/7LFw87lp33J5FWO652rJZBQLbkkZythMwOiFMAnt755YUCmWHvoYh+suJBaO3+4Hd
         NeA7GP1XTtdwKheGKSZ/hZ2yyIN676UNPDKrn0Ih08NoALAbXTKhynceno3AZt52GfrV
         jWz/ecxKVFJv6UCX3O6yCYDXhhbQloU5kAI/mih8wvpTSAuHkqa19KpqzQQZTOVTEI4F
         saeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773721848; x=1774326648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFQPhmx+ISxO6Fn3xc13MwW50zT+1NZPXlLC27SUdek=;
        b=dcHz9jWSigF+3BARnPnbKteLX4VaADjtLsdaMyhGyNJV6JIimRYsLO4x7EbK9BzBKm
         mEBNOo5L0VUPl/dip+HXrZAa92QHbbWUxIR33fHYlLzQokFDwQJjBzeRf/caR0pjg2Mo
         34+rdKlPO1pqvYIaUSk19WaF9PSBtDSVR0MEozQlDzToqkl/jokmLSbZZk4UFJtqHEmi
         kXCC+DmS5SZkg30BADq3NkbtYVryfdZAaKXoYS6JLFIzqMyrVPWUXccsrILfv3Xl/Xkd
         r80MwV7t7nyhZxw2K0hrEcQ6qFdzAhEIEtys7scmuZDaSQSy0hx5l9Sk892/mMBb7UNJ
         O8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773721848; x=1774326648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pFQPhmx+ISxO6Fn3xc13MwW50zT+1NZPXlLC27SUdek=;
        b=sodpc1yZW7F0aelaO3WpwjeEmri14ErXpSmTmv8fKmGCAnwo9Z2h5wD5EFOFL+4TbD
         be+Qodzye/QdWQn/nUPsVOA2f+HZ4Z/mKXgu2TdWch76iHTtzBbxkRAA7ZBMA24rEpr0
         WheiHiqrQb80DxO5DqirR9/cnaGSUYmwyKYrYfN3axpGWmxOxJ3/7xovTtfUjN0A3h/Q
         FM7+1PCNcZGaW67MQdzlSEvKGdOMllY9xOwuzZXPaRke/v05PB0L5akvcvURPg6ps8Ko
         1eWXHKZtkPu8ea4I2FhkbDwRg/8eKg2BOjNo8r8tGo2EW3pSEZqOLxDWwYdeql9Orimo
         w8aA==
X-Forwarded-Encrypted: i=1; AJvYcCXJd9EJHEMfHo8Bu5rDwyJc52gZ9A7n9+9v7Rx/MDquNUZseeM31R0F7Bk5Wg/luKNtgxVdUNauiCYkcBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Own5Soxfp1uoS14aSoroOaNwg/J9UEOELorhLzM9RzxO9d2W
	mRa41VbaudEbXYAjqRcP3R/QvtNO5b+wI2fj0DQQSg5/db7jth1y6AydLFWFJg/ZTSgDxDJi+Cn
	0hnliWGUF2OZevGedyGS7DaMrmSIT07t/HxJAJP5B
X-Gm-Gg: ATEYQzz3z1mDnTYBBtMI5Mpr/BOX7c2L2+I9iSFZM62TfU/ZOKzLXkSHTpDxUdLCWYo
	FCenn6Rs/wsz/hxeitA3tqWTrIO9kcUyRn2YeakVeezYNii6uNVnXGbpCCoT32XABp/6e0ROfi4
	BDClh1YWQhC7IcCMb/GNWZotzJkdNPzM8NP32ZQUpwt010aaMn/Rsa6PCv3o62ImJlHEhd5Ubjf
	ug69Uqxq7YzZ13TgIIiRVZoTBH0qtFqBHCk/GTzt62gT8jW9c11ae9ftjAwoFzX0jm8omN3Gr4O
	gVgw2A==
X-Received: by 2002:a05:622a:1b92:b0:509:1eca:6d24 with SMTP id
 d75a77b69052e-50998c190femr8741161cf.2.1773721847648; Mon, 16 Mar 2026
 21:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773695307.git.ljs@kernel.org> <77fbdae93f250fa1551f3052fc9034739795ff20.1773695307.git.ljs@kernel.org>
In-Reply-To: <77fbdae93f250fa1551f3052fc9034739795ff20.1773695307.git.ljs@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 16 Mar 2026 21:30:36 -0700
X-Gm-Features: AaiRm50ZCLTl3QDNivnPnY48qRQMsgXcmE9SOEgt_D7vDyjlZ8af9f8bQZf6tcw
Message-ID: <CAJuCfpFdKjix2fEdZ7iSrd_nk4-5e7EUNAoCEgUc5snKzq-3Cg@mail.gmail.com>
Subject: Re: [PATCH v2 07/16] misc: open-dice: replace deprecated mmap hook
 with mmap_prepare
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "K . Y . Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Bodo Stroesser <bostroesser@gmail.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Hildenbrand <david@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, 
	linux-staging@lists.linux.dev, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-afs@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9481-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,suse.com,google.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[surenb@google.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A68A2A3C0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 2:13=E2=80=AFPM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> The f_op->mmap interface is deprecated, so update driver to use its
> successor, mmap_prepare.
>
> The driver previously used vm_iomap_memory(), so this change replaces it
> with its mmap_prepare equivalent, mmap_action_simple_ioremap().
>
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  drivers/misc/open-dice.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/misc/open-dice.c b/drivers/misc/open-dice.c
> index 24c29e0f00ef..45060fb4ea27 100644
> --- a/drivers/misc/open-dice.c
> +++ b/drivers/misc/open-dice.c
> @@ -86,29 +86,32 @@ static ssize_t open_dice_write(struct file *filp, con=
st char __user *ptr,
>  /*
>   * Creates a mapping of the reserved memory region in user address space=
.
>   */
> -static int open_dice_mmap(struct file *filp, struct vm_area_struct *vma)
> +static int open_dice_mmap_prepare(struct vm_area_desc *desc)
>  {
> +       struct file *filp =3D desc->file;
>         struct open_dice_drvdata *drvdata =3D to_open_dice_drvdata(filp);
>
> -       if (vma->vm_flags & VM_MAYSHARE) {
> +       if (vma_desc_test(desc, VMA_MAYSHARE_BIT)) {
>                 /* Do not allow userspace to modify the underlying data. =
*/
> -               if (vma->vm_flags & VM_WRITE)
> +               if (vma_desc_test(desc, VMA_WRITE_BIT))
>                         return -EPERM;
>                 /* Ensure userspace cannot acquire VM_WRITE later. */
> -               vm_flags_clear(vma, VM_MAYWRITE);
> +               vma_desc_clear_flags(desc, VMA_MAYWRITE_BIT);
>         }
>
>         /* Create write-combine mapping so all clients observe a wipe. */
> -       vma->vm_page_prot =3D pgprot_writecombine(vma->vm_page_prot);
> -       vm_flags_set(vma, VM_DONTCOPY | VM_DONTDUMP);
> -       return vm_iomap_memory(vma, drvdata->rmem->base, drvdata->rmem->s=
ize);
> +       desc->page_prot =3D pgprot_writecombine(desc->page_prot);
> +       vma_desc_set_flags(desc, VMA_DONTCOPY_BIT, VMA_DONTDUMP_BIT);
> +       mmap_action_simple_ioremap(desc, drvdata->rmem->base,
> +                                  drvdata->rmem->size);
> +       return 0;
>  }
>
>  static const struct file_operations open_dice_fops =3D {
>         .owner =3D THIS_MODULE,
>         .read =3D open_dice_read,
>         .write =3D open_dice_write,
> -       .mmap =3D open_dice_mmap,
> +       .mmap_prepare =3D open_dice_mmap_prepare,
>  };
>
>  static int __init open_dice_probe(struct platform_device *pdev)
> --
> 2.53.0
>


Return-Path: <linux-hyperv+bounces-9482-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qE8fJbDZuGmjkAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9482-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 05:33:52 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFC62A3BDD
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 05:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 615F73001FE4
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 04:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241DE1FF7B3;
	Tue, 17 Mar 2026 04:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XOHBHWty"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FA032B98D
	for <linux-hyperv@vger.kernel.org>; Tue, 17 Mar 2026 04:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773722013; cv=pass; b=HLTFU7/Uphcrzw/IQv3uzana6wX1l7dru8GivUDVy1tjJcQnWgNLlYZYd7c5AcCk2yAAMRpXZsejTAKcQBmZC6O+aKkA2g6AZ2sqmw83n/a6sPECQLVHq41KgNnKcJ7Dk/EQ8rfpmRFCP2ljrw0dJfUthMXWgdJ+Olk+PMXMSz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773722013; c=relaxed/simple;
	bh=tiOslg2ijiNLvUEule9D7TB3nKCRsqgcCv7YiVviGdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sVspszNDwkJFW9tg2cGBeKMaUVCnte6lCQuQRHh3JUULPeENzsSqF5thg2waSUlcd6+1G8opp5a2xLrpOGgC3pEGgE8Om1ydNKqokLoPXdtQWrkEDWf0mZioJzz5D4VOP4fkHxonCZPnF53Zp3NzpG0dlqiatJsGJXAlieISmbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XOHBHWty; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-509062d829dso230951cf.1
        for <linux-hyperv@vger.kernel.org>; Mon, 16 Mar 2026 21:33:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773722011; cv=none;
        d=google.com; s=arc-20240605;
        b=f8D6xqovJK52S+y6XMjrzcEqMEyjKFKVVo0XSSgDlLWXqqxw3XwinCwwXzMgzKhg1S
         454HcPdmBwBSp4gIw1AHYqXBDKxhsjTUuSC687xy8O1xwQL1t7G/mMCI3Ui19+Bucn3g
         5tCLfVe5+FIKq3+Twh2Bwki3neGPjTfJcmdSuq0oudcVbvV+Vvw+EwxPTXbOkW9hAZIt
         s5wezNwfepljy3CpbvRV7YpnExzE62cQ1DheABVywjyYTkuy6ri8XquJyuugwUNtjRd9
         kAJozTg+T7P0pCd+rDQY+8Kuzl4I0chk0PobiSNRBs7u0eualWhAFUgIjw8ExhDF/9JB
         chmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/NEZIoIL+p9WYNIWM8eip/yr8eeRSa2d7nrT0z5B5yM=;
        fh=6CiSSk0wt3hfQ2975TYbQe5jbEH649jeXXspD5mQfiY=;
        b=XYbjbxxcw68RTNZ0IY+NjplRU129oe0IMXWDCxtmu8gBx6tB7Qif2zkmneWBpo4Nio
         iM9Rex/cjABogCiX9FyO/YZshO74RQjmIPcTW1335SFTMzJtfv2nurcGPucR+LcltCdX
         0NqNi70INl8snbUj9Tg3NHj0l3n8YSjUaGy9mQwWXFSEzq7a2JfK934wIAktP0p/L+SI
         KlxSfK3qnjTdmmCRp6cFDBAMZUupywnLO58gMNTYbXH0QrUyhmBpPn+LZbVRGnPiXKSN
         aKX7x5IHUxTbSmtKIgjMh49vmpvuAwEFfmh0LgnbiQyBjgEiPu+nkKeZoA7QwMU1LM7R
         EyUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773722011; x=1774326811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NEZIoIL+p9WYNIWM8eip/yr8eeRSa2d7nrT0z5B5yM=;
        b=XOHBHWtyrlsh7Yoa4vNnjb6T9UyuOpn+BAQwM6/uhn8ej309RDdBFaM0vYPVNGoxBD
         fZ4VRrRF0P1oXYGRPa1P6vXDW4hEkqYusYkSgtFEpwEaBMZSkbBuOzVEGkYjLbJnG0ce
         QU79t/gmXkvF21hP+Hh0ZK69g3kK819Gvg5zCvpU2oo0xApP7o57C/wEJJ0VBa6Bacey
         wjarTwWHd65HU/pv9GZujDxU1zzk1io+Q5IMCyzum2RA6KkJ9FSc0WAExQYW1SjbtbTt
         34LW/Y1yWWNLOSsBOPPxDUV5NcywSZ15RzaSRhQvYN6v7clysze7Sd3FTfZBv4btjwv1
         gjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773722011; x=1774326811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/NEZIoIL+p9WYNIWM8eip/yr8eeRSa2d7nrT0z5B5yM=;
        b=sMaeZFC1+7nkmsaHfpfVEJLvV1ssdwnC9wtkRMA9Sgd5ftpMR3BAMY9/2OSxXGsAYE
         qzqT5mK+vyNq2HZjQJ7Fc1y+aOCHz/p6AqyWbXNhy15A/qyJ+2WdQdyED7QR+aY5qZDc
         GtS3TX7S2hSN11NM+Wbdn3n6JLt40Ws/Cz17RfSKWZ7fmF+N9ulhcE2wsbmriRQLj/9v
         UByWf5zqDMd0/N8pC9aEhTmA+XlQ6XJLHyz+gQXKqfgN/UHiXE09PNRJGxY2v2mYOKG0
         MWn1zqVjwfLR6lPUiV235r07JoRk3QR/uc7FLYP2JJTyWAOb0dsd3moj9+LKzZbBzG7m
         Sq5A==
X-Forwarded-Encrypted: i=1; AJvYcCWDohq37Su3lmCr58xg0jCwerDudNX/5pef/0GH3YPFwSNCQLBrLEszOqcqOYL40aKFycds7fhPppaYHaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC2jxJ1yCXZ5x0LKip5UsW2DYvCWLoNndQJHHQJP8DErPJj78p
	Jdors0h5oRWeiLbbhJob2VgvDeRMcE3/mSsEij6c4NjHFagHdH4BPKXLN3BMWXj9wezBTT81ewF
	/Dv7KR7mCFfvFq6HMcB7ETxBZvsRbOZnaJOXrvs5L
X-Gm-Gg: ATEYQzwyWCmG4a1eOGlVjxCCvfaoa7MO7orbPmWzyYJy2lsgJZqFeCCys1iytsx+/u2
	5miQAT+e3/Iy1KMFn5piZmsovU/K9vwN1LyEAgbKPuAv1EDJXkwBZiNSs9oCs4dn1kkyvFfG21X
	WotShyS7RhTbys9rpec/SMx3Q6MEW5W379YbGT3lDkKcOSjqA8C0VHvmeSXTuPRk7dTWkFQNX5r
	Qa1rbdc7+kZmmaHr2pcYyhBOhgHiE1sUNJtK7NsFVaebDbzl3Kh5K+xyEhyjM8GBOIQmg6Lp8G0
	wcKvRg==
X-Received: by 2002:ac8:5844:0:b0:509:cd7:aa18 with SMTP id
 d75a77b69052e-50998d3b42cmr9273521cf.10.1773722010151; Mon, 16 Mar 2026
 21:33:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773695307.git.ljs@kernel.org> <a8debbca3fc7b765937e6b5b76bd9002c66b225b.1773695307.git.ljs@kernel.org>
In-Reply-To: <a8debbca3fc7b765937e6b5b76bd9002c66b225b.1773695307.git.ljs@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 16 Mar 2026 21:33:19 -0700
X-Gm-Features: AaiRm50Qx7Mej7rYBXyqChXz1IjfagNMkbSFlVwOhEN7Z-gN2V6TQSUIzNbqMWk
Message-ID: <CAJuCfpHBfD0zO60tPCEeNXSRJSoDi5Azs0LzutpYFEBW2z6JJw@mail.gmail.com>
Subject: Re: [PATCH v2 08/16] hpet: replace deprecated mmap hook with mmap_prepare
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9482-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CFC62A3BDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 2:14=E2=80=AFPM Lorenzo Stoakes (Oracle) <ljs@kerne=
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
>  drivers/char/hpet.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
> index 60dd09a56f50..8f128cc40147 100644
> --- a/drivers/char/hpet.c
> +++ b/drivers/char/hpet.c
> @@ -354,8 +354,9 @@ static __init int hpet_mmap_enable(char *str)
>  }
>  __setup("hpet_mmap=3D", hpet_mmap_enable);
>
> -static int hpet_mmap(struct file *file, struct vm_area_struct *vma)
> +static int hpet_mmap_prepare(struct vm_area_desc *desc)
>  {
> +       struct file *file =3D desc->file;
>         struct hpet_dev *devp;
>         unsigned long addr;
>
> @@ -368,11 +369,12 @@ static int hpet_mmap(struct file *file, struct vm_a=
rea_struct *vma)
>         if (addr & (PAGE_SIZE - 1))
>                 return -ENOSYS;
>
> -       vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
> -       return vm_iomap_memory(vma, addr, PAGE_SIZE);
> +       desc->page_prot =3D pgprot_noncached(desc->page_prot);
> +       mmap_action_simple_ioremap(desc, addr, PAGE_SIZE);
> +       return 0;
>  }
>  #else
> -static int hpet_mmap(struct file *file, struct vm_area_struct *vma)
> +static int hpet_mmap_prepare(struct vm_area_desc *desc)
>  {
>         return -ENOSYS;
>  }
> @@ -710,7 +712,7 @@ static const struct file_operations hpet_fops =3D {
>         .open =3D hpet_open,
>         .release =3D hpet_release,
>         .fasync =3D hpet_fasync,
> -       .mmap =3D hpet_mmap,
> +       .mmap_prepare =3D hpet_mmap_prepare,
>  };
>
>  static int hpet_is_known(struct hpet_data *hdp)
> --
> 2.53.0
>


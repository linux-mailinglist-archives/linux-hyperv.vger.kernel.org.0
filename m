Return-Path: <linux-hyperv+bounces-9510-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIQ2ChHHuWluNgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9510-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 22:26:41 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE832B2AB5
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 22:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1CD9F304C6B4
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 21:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4BE3921CD;
	Tue, 17 Mar 2026 21:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TKpXCaIz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B5E3914F6
	for <linux-hyperv@vger.kernel.org>; Tue, 17 Mar 2026 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782796; cv=pass; b=SKQfc0O/Jrq/NvHG2KiYYuv0/q2JHVpYhi5HEBqUpcj7hQ6idJpHDW76/jsuC0JRcPseB8LC8g+dV9uV1UItazBQ+2QTAokiRXwUXNbwJnldrflsI4hI0sQ0xwQAr8XTCw4qlncIMePld5CFgwBxLAHTN5FfMi+r+1KocIglHl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782796; c=relaxed/simple;
	bh=LDRxpmDHqVACRLxJTnLszzlV2/NLpmV53JWM+2p1hpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srt8zG7neGXPXDGqKES4jh6LQW4glr+GCJSZw17oDgfL/qshqZPFb6LQvHB0/H6GZgujrpSbk05xer57VOuwqT65SmS9+kPOM4E4tgsjdLObBOihH9Ok2e9NOd7tdGSC4lW4CTMkRAozj2bbpktMKoOdG9VaXoAhm+wc3WSRfZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TKpXCaIz; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50906a98ffeso171301cf.0
        for <linux-hyperv@vger.kernel.org>; Tue, 17 Mar 2026 14:26:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773782793; cv=none;
        d=google.com; s=arc-20240605;
        b=dVmSy85IC91eiwBBODql/kT7aynIFeOgU2bWf8zOWcxnb8lBBOD8YduVqKl/Kdy0t3
         p5hra4qj70YoQshdBvRdF9yFmb71Y/WuSrJjHudOf61asKpO82BIme8adKQoXeAWwl/z
         eK5gCajFnJ9Vv8MdtfY6DDMQ/2vbx/XcGLBHA2D2sBp0Gpb3p70TIGtUcaVwRwCGyowG
         Z2iczc/og3moBYV5QSwpG00NmW0ZbBAKK8k65Mc9LKf1HbT/K/8srgWPwxdBMHlQS1n5
         wWsn0y6H/EuKSlZB60murrUKXTw6iMlB9c69X67HmrZTkn6W3Egcvk/L+9c0CtjDLorW
         795w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O9MljJMIpne7nbSW7i1x1Or1SMzjT+hBLrQOgGeQvrk=;
        fh=6fLv+HzTwQVvXhBhCc9SQCMdsz3k8jbPFt3sGU4/io0=;
        b=RkK0F0x1MFus2D43vLm+0+FLn+6qzFVibH0LwEevG8JlAzoy3NESg+vui03JjBPlaZ
         FkqW/xKxybYbGknN0sJzmOO3Zq0E2KthpVtNGbR0h+IonvE+we1rzQ/2psu7tpGrlmbg
         IsYzLNj3U3zP60GszmLy1mlAWChQIEhLbA48xqCmcnx3a7XZ2lHVqBLzRo1wj7XPKqov
         4nJT7mtVz/QUm2xMtQZHAgecYONJWYptBZbGyITsBJ31WcoBSjpmPV3cJutLla+Y1KkB
         gVQ+rmuM4Y3dRi5qlLATXk96V60iRIcdRn7aNret7xJrWyuGNyYwaR+3bVJ/DpDF+DLt
         7eiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773782793; x=1774387593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9MljJMIpne7nbSW7i1x1Or1SMzjT+hBLrQOgGeQvrk=;
        b=TKpXCaIzakLTLVXTv9kjgruZSwYkSJdfft392Az1fl49JSLon7kY0NtE/gyhEZtapR
         TvoHtLjjbPnArV4oO5HSzekiAZMuEuskED9kriSFOQPKp9pAjr/SyVgY2BjSkKCa1cOx
         hSbIcxShgTvRNhTxvQdd6H4DnOwDs42l2O7t4cEtTn4DCARCYUWcXZc4qvWZBlI786A/
         6EL/Wnuohoku9m0fwIuPXOJly5tlb/PLi79pcOgJ5ReinYe+gmBFTfJGWOEWE5814jJv
         SEmQj6soSa/abnsCDLbU8OR/8O3WisuU9x6Jt5c1BdtVZA2s6WPaLWKEiwUY5BbXz2f0
         M82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773782793; x=1774387593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O9MljJMIpne7nbSW7i1x1Or1SMzjT+hBLrQOgGeQvrk=;
        b=WpSTHlkmLNqH31Ze3PnGwRUq20lgzvhckKF///4pRxKox2d/itNHAfbk8FsnU72p5u
         5LmOPih42XWWiv9cfZYyShxUbqSpE5Nyva9ve2bDXm1fcJLeWtiHwz/7igj3VWGVV1d9
         9IyvzD8LH7PftcYBDxqy8PcIRgRlhQyCpvmNRbPUHYfN1aL7lwRSiTIT5FYSgegu+Rxb
         C+uppn91NCRtsjkjju9+N+Xdq7OSZQJYRh6jxhdV0EeRrqkrZ7shH3J7SUDHhKIFCPCv
         E/346wT+RlAaCO342JZVu1O1l7U9p/wma2eFII1tLCRSP1g8x4wq8vrK/Cjo2Lz4KN5w
         MYIg==
X-Forwarded-Encrypted: i=1; AJvYcCUDJmxI7WaIw0h36oYw/iraktqj6wRwZLRknm2ag0kCbkV1f2ALUX3pRgGZ6YKAhSCsMNH2MltPUBMlgXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDHoMkUo22rlUN6LFtGOEUjRKPK7fMUk0sMtgIzUbYCt6Qlsk5
	v0HKaqaBvCxotzh4OizT+KIhRw9zDT8RirP0MaIYt3LdmQF+NmoNT0adX2u6ux9nM4rYoiB9Fma
	nTkObaxjHFwM6UVfrmuKv+OIzDBIfWsifNxJhM7sX
X-Gm-Gg: ATEYQzxHkxFjjiRcoqwn0pe3LMzHF+9eUkcejwuh4Bo7GNGB/GLQ6G8K61qB5S0Miyp
	uDpDjMStK2MeuYwKD3v3ShE01K0PMAU9Z3zkg2H4nRsri6xXwwckKpUeV4ERtY3ckHpZT7Aoely
	xT30d/qMtz1etVDs58vGJgO+u5A8XlHrBXiZagGGPM894s2XGyc/8NMeIcYpFBK+u4Mda9NMEsz
	2Hlnm65Lia8hnzfePM5pRYWI5uUkeCaNMy+xDa1yEXfsh7xWo9a8BqbvCG0zOfNDyeQN/Krz+L4
	MiTy3d0s2RLJnQgdFRsnhdTZIBwtjOFEEiETyA==
X-Received: by 2002:a05:622a:614:b0:509:1eca:6d24 with SMTP id
 d75a77b69052e-50b1470ee58mr4568251cf.2.1773782792685; Tue, 17 Mar 2026
 14:26:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773695307.git.ljs@kernel.org> <48c6d25e374b57dba6df4fdddd4830d3fc1105be.1773695307.git.ljs@kernel.org>
In-Reply-To: <48c6d25e374b57dba6df4fdddd4830d3fc1105be.1773695307.git.ljs@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 17 Mar 2026 14:26:21 -0700
X-Gm-Features: AaiRm51SJauRxJyG8YD3YuiOnfN0s_6akSz6AhkIFbo6vEz-Gt-mAXyXfHq04tA
Message-ID: <CAJuCfpFXuHg4KPY27pqMC-xV5y9ZY2W72_R8_rxO0DvrJ=_yvw@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] staging: vme_user: replace deprecated mmap hook
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9510-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ADE832B2AB5
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
> Functions that wrap mmap() are also converted to wrap mmap_prepare()
> instead.
>
> Also update the documentation accordingly.
>
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> ---
>  Documentation/driver-api/vme.rst    |  2 +-
>  drivers/staging/vme_user/vme.c      | 20 +++++------
>  drivers/staging/vme_user/vme.h      |  2 +-
>  drivers/staging/vme_user/vme_user.c | 51 +++++++++++++++++------------
>  4 files changed, 42 insertions(+), 33 deletions(-)
>
> diff --git a/Documentation/driver-api/vme.rst b/Documentation/driver-api/=
vme.rst
> index c0b475369de0..7111999abc14 100644
> --- a/Documentation/driver-api/vme.rst
> +++ b/Documentation/driver-api/vme.rst
> @@ -107,7 +107,7 @@ The function :c:func:`vme_master_read` can be used to=
 read from and
>
>  In addition to simple reads and writes, :c:func:`vme_master_rmw` is prov=
ided to
>  do a read-modify-write transaction. Parts of a VME window can also be ma=
pped
> -into user space memory using :c:func:`vme_master_mmap`.
> +into user space memory using :c:func:`vme_master_mmap_prepare`.
>
>
>  Slave windows
> diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vm=
e.c
> index f10a00c05f12..7220aba7b919 100644
> --- a/drivers/staging/vme_user/vme.c
> +++ b/drivers/staging/vme_user/vme.c
> @@ -735,9 +735,9 @@ unsigned int vme_master_rmw(struct vme_resource *reso=
urce, unsigned int mask,
>  EXPORT_SYMBOL(vme_master_rmw);
>
>  /**
> - * vme_master_mmap - Mmap region of VME master window.
> + * vme_master_mmap_prepare - Mmap region of VME master window.
>   * @resource: Pointer to VME master resource.
> - * @vma: Pointer to definition of user mapping.
> + * @desc: Pointer to descriptor of user mapping.
>   *
>   * Memory map a region of the VME master window into user space.
>   *
> @@ -745,12 +745,13 @@ EXPORT_SYMBOL(vme_master_rmw);
>   *         resource or -EFAULT if map exceeds window size. Other generic=
 mmap
>   *         errors may also be returned.
>   */
> -int vme_master_mmap(struct vme_resource *resource, struct vm_area_struct=
 *vma)
> +int vme_master_mmap_prepare(struct vme_resource *resource,
> +                           struct vm_area_desc *desc)
>  {
> +       const unsigned long vma_size =3D vma_desc_size(desc);
>         struct vme_bridge *bridge =3D find_bridge(resource);
>         struct vme_master_resource *image;
>         phys_addr_t phys_addr;
> -       unsigned long vma_size;
>
>         if (resource->type !=3D VME_MASTER) {
>                 dev_err(bridge->parent, "Not a master resource\n");
> @@ -758,19 +759,18 @@ int vme_master_mmap(struct vme_resource *resource, =
struct vm_area_struct *vma)
>         }
>
>         image =3D list_entry(resource->entry, struct vme_master_resource,=
 list);
> -       phys_addr =3D image->bus_resource.start + (vma->vm_pgoff << PAGE_=
SHIFT);
> -       vma_size =3D vma->vm_end - vma->vm_start;
> +       phys_addr =3D image->bus_resource.start + (desc->pgoff << PAGE_SH=
IFT);
>
>         if (phys_addr + vma_size > image->bus_resource.end + 1) {
>                 dev_err(bridge->parent, "Map size cannot exceed the windo=
w size\n");
>                 return -EFAULT;
>         }
>
> -       vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
> -
> -       return vm_iomap_memory(vma, phys_addr, vma->vm_end - vma->vm_star=
t);
> +       desc->page_prot =3D pgprot_noncached(desc->page_prot);
> +       mmap_action_simple_ioremap(desc, phys_addr, vma_size);
> +       return 0;
>  }
> -EXPORT_SYMBOL(vme_master_mmap);
> +EXPORT_SYMBOL(vme_master_mmap_prepare);
>
>  /**
>   * vme_master_free - Free VME master window
> diff --git a/drivers/staging/vme_user/vme.h b/drivers/staging/vme_user/vm=
e.h
> index 797e9940fdd1..b6413605ea49 100644
> --- a/drivers/staging/vme_user/vme.h
> +++ b/drivers/staging/vme_user/vme.h
> @@ -151,7 +151,7 @@ ssize_t vme_master_read(struct vme_resource *resource=
, void *buf, size_t count,
>  ssize_t vme_master_write(struct vme_resource *resource, void *buf, size_=
t count, loff_t offset);
>  unsigned int vme_master_rmw(struct vme_resource *resource, unsigned int =
mask, unsigned int compare,
>                             unsigned int swap, loff_t offset);
> -int vme_master_mmap(struct vme_resource *resource, struct vm_area_struct=
 *vma);
> +int vme_master_mmap_prepare(struct vme_resource *resource, struct vm_are=
a_desc *desc);
>  void vme_master_free(struct vme_resource *resource);
>
>  struct vme_resource *vme_dma_request(struct vme_dev *vdev, u32 route);
> diff --git a/drivers/staging/vme_user/vme_user.c b/drivers/staging/vme_us=
er/vme_user.c
> index d95dd7d9190a..11e25c2f6b0a 100644
> --- a/drivers/staging/vme_user/vme_user.c
> +++ b/drivers/staging/vme_user/vme_user.c
> @@ -446,24 +446,14 @@ static void vme_user_vm_close(struct vm_area_struct=
 *vma)
>         kfree(vma_priv);
>  }
>
> -static const struct vm_operations_struct vme_user_vm_ops =3D {
> -       .open =3D vme_user_vm_open,
> -       .close =3D vme_user_vm_close,
> -};
> -
> -static int vme_user_master_mmap(unsigned int minor, struct vm_area_struc=
t *vma)
> +static int vme_user_vm_mapped(unsigned long start, unsigned long end, pg=
off_t pgoff,
> +                             const struct file *file, void **vm_private_=
data)
>  {
> -       int err;
> +       const unsigned int minor =3D iminor(file_inode(file));
>         struct vme_user_vma_priv *vma_priv;
>
>         mutex_lock(&image[minor].mutex);
>
> -       err =3D vme_master_mmap(image[minor].resource, vma);
> -       if (err) {
> -               mutex_unlock(&image[minor].mutex);
> -               return err;
> -       }
> -

Ok, this changes the set of the operations performed under image[minor].mut=
ex.
Before we had:

mutex_lock(&image[minor].mutex);
vme_master_mmap();
<some final adjustments>
mutex_unlock(&image[minor].mutex);

Now we have:

mutex_lock(&image[minor].mutex);
vme_master_mmap_prepare()
mutex_unlock(&image[minor].mutex);
vm_iomap_memory();
mutex_lock(&image[minor].mutex);
vme_user_vm_mapped(); // <some final adjustments>
mutex_unlock(&image[minor].mutex);

I think as long as image[minor] does not change while we are not
holding the mutex we should be safe, and looking at the code it seems
to be the case. But I'm not familiar with this driver and might be
wrong. Worth double-checking.

>         vma_priv =3D kmalloc_obj(*vma_priv);
>         if (!vma_priv) {
>                 mutex_unlock(&image[minor].mutex);
> @@ -472,22 +462,41 @@ static int vme_user_master_mmap(unsigned int minor,=
 struct vm_area_struct *vma)
>
>         vma_priv->minor =3D minor;
>         refcount_set(&vma_priv->refcnt, 1);
> -       vma->vm_ops =3D &vme_user_vm_ops;
> -       vma->vm_private_data =3D vma_priv;
> -
> +       *vm_private_data =3D vma_priv;
>         image[minor].mmap_count++;
>
>         mutex_unlock(&image[minor].mutex);
> -
>         return 0;
>  }
>
> -static int vme_user_mmap(struct file *file, struct vm_area_struct *vma)
> +static const struct vm_operations_struct vme_user_vm_ops =3D {
> +       .mapped =3D vme_user_vm_mapped,
> +       .open =3D vme_user_vm_open,
> +       .close =3D vme_user_vm_close,
> +};
> +
> +static int vme_user_master_mmap_prepare(unsigned int minor,
> +                                       struct vm_area_desc *desc)
> +{
> +       int err;
> +
> +       mutex_lock(&image[minor].mutex);
> +
> +       err =3D vme_master_mmap_prepare(image[minor].resource, desc);
> +       if (!err)
> +               desc->vm_ops =3D &vme_user_vm_ops;
> +
> +       mutex_unlock(&image[minor].mutex);
> +       return err;
> +}
> +
> +static int vme_user_mmap_prepare(struct vm_area_desc *desc)
>  {
> -       unsigned int minor =3D iminor(file_inode(file));
> +       const struct file *file =3D desc->file;
> +       const unsigned int minor =3D iminor(file_inode(file));
>
>         if (type[minor] =3D=3D MASTER_MINOR)
> -               return vme_user_master_mmap(minor, vma);
> +               return vme_user_master_mmap_prepare(minor, desc);
>
>         return -ENODEV;
>  }
> @@ -498,7 +507,7 @@ static const struct file_operations vme_user_fops =3D=
 {
>         .llseek =3D vme_user_llseek,
>         .unlocked_ioctl =3D vme_user_unlocked_ioctl,
>         .compat_ioctl =3D compat_ptr_ioctl,
> -       .mmap =3D vme_user_mmap,
> +       .mmap_prepare =3D vme_user_mmap_prepare,
>  };
>
>  static int vme_user_match(struct vme_dev *vdev)
> --
> 2.53.0
>


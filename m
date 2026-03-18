Return-Path: <linux-hyperv+bounces-9530-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KABK1bdumk3cwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9530-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 18:13:58 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F102BFFFE
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 18:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5015032DFADE
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 16:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483853939C5;
	Wed, 18 Mar 2026 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wm0jPzpe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A451E3491F1
	for <linux-hyperv@vger.kernel.org>; Wed, 18 Mar 2026 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849746; cv=pass; b=NSZiBA/M6Bi8xVwXBYrU3Eozowf7deBFN7OgdQsyZdD032YrqWsz7B4goNCC7Z8YxFKehuQK5OMup3vanawqXfDRVnKKGj+2GhShMvrtG5h6xHjSWKcGQy3NX+N+6OE6/D3kBl1/iPJ/jYDGU8H40avB/jvJrfCxGplk/sntXQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849746; c=relaxed/simple;
	bh=Sn9jbrHlytwm6vm7UMn5Ci63+904PwFRZxmCisoVDck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHHD9hzkrsFvp/UClmDtgULhzs7gIWDyJrXuNia7xd5HxDi0k+Lw35DnLddodXMlCmYbwmrC6KJKcmjTbVMXI7yQJmutoYONe4XC0y7AwS/t5owjt8F9nlW6p2ctJageRHs6YDNQkD6+7CgqFtTLSGh8m7uK0uP3buvrg4RJ1pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wm0jPzpe; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-509062d829dso620701cf.1
        for <linux-hyperv@vger.kernel.org>; Wed, 18 Mar 2026 09:02:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773849738; cv=none;
        d=google.com; s=arc-20240605;
        b=ICFS/RrBYtjY5pIZ13CTznluczowPiXykI6LKMAuQ7UFT4QEh70sVxY7w9TNDRCD3O
         pL6+DNbcCOUCm6ELyD34meQQx4oD5ANrdZB1TWcsx8U4H6K5ClmWR4njz8D4MWQoNJzo
         9lh1yeUKDgofVyNj2nCQSehXk53DEF28t5OU8+foUOBG5wPFiPqp97qYDWVex+f5K3WA
         Wet45ths+rDCX1uJI4cENqRXKHDhzt15V0gOWu/ql7AAQSRUt98sKkiBOfm3U6z8IPOe
         yHeQRqHjLV+6MVJWLkKkjy/i1N7ZaEy3Xf26g0GlN1qhh0VDKgtje65DaifygrezqocD
         DN7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bBf0X4ZI8hrueKElVjOm/fdCiPNUuzJRpv2jzIUCVLI=;
        fh=BfDH6NDRtHuq8UauHrOH5A4kIig47mA13vQcKaNY+hE=;
        b=J5ufwrxNpbrpzm/mBk2AmlA63I+tYbvD2uocBNBPpmKRQ3KIMzh3TVzgt+FYAhly6K
         KRCyIcwyAfB1FBULap8hBm53NrhcW9PLgm1fwkOu8nsVj0SnCJnrLcGsH7peao0WvWIK
         FVuhOn45QVDk9mJMjXUq18tBRtq2+yfZYqUEVOqF3ruiYWsRd5JQwKheyoiY3y+ZppQ4
         /3YaKhvMEua9iL7FbXM9QGnCsGVnsGVY2xF42b7nAfJa2g4bd/t3mXQAxgyZGu87/cPq
         dXNeF/r+UmLY4YACZzBa6k/r0a7qrYfwcaf+HbLuwdGdQGBUkxZ26YHryY+iZgm23/d/
         Zk5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773849738; x=1774454538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBf0X4ZI8hrueKElVjOm/fdCiPNUuzJRpv2jzIUCVLI=;
        b=Wm0jPzpeHp5dNdtnLhc5H1xUtQtEyN6dAuXQxuM0/SN+dHfWxkgkDLEv16Sd+NSk4R
         W3zwVULhxvCobeOJ60+FPx2K3eBstNvsz1o15jYru4GL4ux6NqrdChHlBZ9x8AUqIq29
         mSh4V0HHJ1KEDYe3hbSIWJt/zucGLqTxfR/1Gy6C4SU1SnJYyWvn9m69CcuCepH7L6C6
         n0wL88/pgPhUZ1Xwjk6REDhoOePUSYUBm/1TlDa4divFXSqbTArdZq/crK4tSKTSMu00
         OMs4vzIJDqWDaaZZ7G+XPePGtrej7nUQn43nj8Vez1JteO0v0mZPWyOk90/G2Tpzi1+W
         Y63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773849738; x=1774454538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bBf0X4ZI8hrueKElVjOm/fdCiPNUuzJRpv2jzIUCVLI=;
        b=RXmiVaVSXxc0R8j1z7SwzPFJ0t857X/GGDH2OWR3E7e88MkTuAAluozPUxgqufPSt+
         tqEtntKVI/uCiG+93gZYZRHjI9um4N2iPuQJswt2XQxtIFeppRUd4EGPkyFXj/VBhNV1
         Gz912Fln+YA3ABpWfcp1c9pyZmjCEA9x0XrZa+XgL7xO7uVvZLdRnQGXzyXcrs+aKCjG
         Xr2eUSeNoWxQafX84qwZVmDDjVawHFMxzDZA0AJrHPVfwcgbcZqphH+BNDUU6IieWoXb
         v+FZY8dDn+tnGcn6xIeIyP4jSFt11P/xm/lgKdS/2KinZcBInCY7ytfvD2CV2iZdbAkU
         F/tg==
X-Forwarded-Encrypted: i=1; AJvYcCX1eEUjbCWtnFH6Xh8VVnKNjNLFQBM4qlFlt/MXNkZr3KTjiZdLLSYCJvAMXoO/Hi9bxZNVqU29vTK1bow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww9H9i0HWmRXHEJi5+Q5IXMWqIrCqWQb0zyZlHvwT0oo36CRBv
	cTb2GXrXwYWg0Mo3qZLU4L5LHK3syoAxy+nEluCEKuSZYcqQPtFrDSW+avxB49Kg4Ad5PPO3cUR
	wOcAunG5p44yo3SLvFO4BFnfLsj3o1dG7vD7mMTiw
X-Gm-Gg: ATEYQzwJNPS7Xi5Q/mV1qGi/zdco6KQZRYB2rqrA0Ne3YUd8oLfcjHyGXgLNmOhy3Uh
	cq6crZjGv2G4TgOy6liXdWm3JAEhcUCV7/ZVE1U0PloCU6uvQ+oUpsBWP8EJOOsw0LyJo6ZnV5C
	UtEwnxFA2hbNy0M90lYxmk2NWtPVovoAdPzmbU34TIhmLFwF4AVXivdEP1Z8uFpt7ovYvHVnW1g
	VGf9hJ/gwIM0O/3hVuipOkcATHfqIfYWHrSJNAzYyQYzOWPV839aG9qmObYkrLa3/FZpizfVk/N
	0UXKyGffPCi9nzQ7MgdcQfTwly6XpS5Qb/GiaLnbzwGu22Lh
X-Received: by 2002:ac8:5d4e:0:b0:4ff:c0e7:be9c with SMTP id
 d75a77b69052e-50b1462cacfmr16816931cf.0.1773849737454; Wed, 18 Mar 2026
 09:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773695307.git.ljs@kernel.org> <4e152e7b8e1a93baf0777628eef9409d031cf8f6.1773695307.git.ljs@kernel.org>
In-Reply-To: <4e152e7b8e1a93baf0777628eef9409d031cf8f6.1773695307.git.ljs@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 18 Mar 2026 09:02:04 -0700
X-Gm-Features: AaiRm52kf0p9Fxu6EolM9nhc_2BIDOLEzyHhrKwtGPKlzkXo42y6XvhNDeOCJ6g
Message-ID: <CAJuCfpFd-d-E24d5-G6=dSYDpyHkwS=aXzGd6+SzyMkgssyPAw@mail.gmail.com>
Subject: Re: [PATCH v2 16/16] mm: on remap assert that input range within the
 proposed VMA
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9530-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.959];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 59F102BFFFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 2:14=E2=80=AFPM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> Now we have range_in_vma_desc(), update remap_pfn_range_prepare() to chec=
k
> whether the input range in contained within the specified VMA, so we can

s/in contained/is contained

> fail at prepare time if an invalid range is specified.
>
> This covers the I/O remap mmap actions also which ultimately call into th=
is
> function, and other mmap action types either already span the full VMA or
> check this already.
>
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/memory.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 849d5d9eeb83..de0dd17759e2 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3142,6 +3142,9 @@ int remap_pfn_range_prepare(struct vm_area_desc *de=
sc)
>         const bool is_cow =3D vma_desc_is_cow_mapping(desc);
>         int err;
>
> +       if (!range_in_vma_desc(desc, start, end))
> +               return -EFAULT;
> +
>         err =3D get_remap_pgoff(is_cow, start, end, desc->start, desc->en=
d, pfn,
>                               &desc->pgoff);
>         if (err)
> --
> 2.53.0
>


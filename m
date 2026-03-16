Return-Path: <linux-hyperv+bounces-9420-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFjhLVFSt2m/PwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9420-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 01:44:01 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA533293221
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 01:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C178F300406A
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 00:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF421CEAC2;
	Mon, 16 Mar 2026 00:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bISgmRPH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C4F139D0A
	for <linux-hyperv@vger.kernel.org>; Mon, 16 Mar 2026 00:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773621835; cv=pass; b=AHnY17XAbkm2TP+PD0r/VzEfQnMJV5Ms9TiQyfNJrIHfkR6z5K5JAnDcvVLuciFa7c+C6hoQc2Whw/oQGoKO5p7xhiIQseyV9qTdyXeBxVNcRbatsrPKsYF4pBtvlgRMH94cWhjd/B8FwX3xGxJfmoYmUFmw7cP/ne2sESEU3fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773621835; c=relaxed/simple;
	bh=7LEG6GSfAF3VAhLmKNS+zMMoXAkVfIwRn9mYIfi1rWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbmMh/oi7ZaP/zthQiMRzkSY3AsZNBwrdnHQ0T1vlaTTlwqVxyg13uUQnb8xLD7fDG3FrJJEOcvBmrqYs/HLYskeJbLece2XQ+iHOCzh8Evj6VjtxsxLIOuU1rL4ktQESDMtQkDEMf2YQoOBxgDSGwDtadldg/ezXjEfs75f6E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bISgmRPH; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-509069a7a7fso778401cf.0
        for <linux-hyperv@vger.kernel.org>; Sun, 15 Mar 2026 17:43:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773621834; cv=none;
        d=google.com; s=arc-20240605;
        b=Vuqc/+k4PHZTwcshYEMit1zbvkHT0bKzezV7vJk+GI/jN+eI+D3AYnHdz1G/c1zdaM
         pDjt4xBYJ0Q4CtqD5pGLugy2PJT43q6gDuvrHKN+pdYooTk4Ygs+GDQWNz0+91Ej5fV2
         +T0VIUCTw1pF6FGgIl4kWYa+BVKhgoanKXryPwvT3bXVVsK9je9mghmxPjGw4vmcC++f
         TwMQPht8Oo/BGVK2yO9S7ket+bbtMr9ojRJPapC4yhAGchJNZNj45U9XGf8UE1H0t9vO
         xEJc3xUEXN8OyrbhTDP7eGEIobGmnL4qEDOXRykLxmcw6ghk2oPWC1DTIj/KgWWLc6c9
         LQKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B4iLbVdU6UwNcjWJZqb9n6er3BcFb6HsfZvwCgpauBo=;
        fh=UNB0oWFjAw00n9bD4mZEbOba0i06SCNEbOCMtkuA+UQ=;
        b=eHiwww4uH3u0vNqkFhYbl+tdSAwXVlD8zvqTIAkMK1YGxL3CI2QVoSKJUMCuMZUzva
         3CsD+MuCr4FXkJnS/HCSzfj1gfDRnX0nnTM4g8qfBPsZ1nF9R8Xvwx9GQDWVG8rY23G/
         BlQ5pm4WDgQ9DGX5jmcL9ThKmtaOZKymB30RdYdB8Oa+EwWBj0XVlpwjsRascqAr/tUY
         yWR4jT1GX0HJXiD+FTrgK/PcDK/8YPp/5JcRX6RQXlxdrnp/7a8LKW8w2saAFe8BA08m
         CYsIezJyOXgLfxIdTIlI2rhYUtmJl2Bh3a2Xktx9S2Q+Cg7V0aYHUnNUhv+wKAzB3aEP
         CynQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773621834; x=1774226634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4iLbVdU6UwNcjWJZqb9n6er3BcFb6HsfZvwCgpauBo=;
        b=bISgmRPHe1Sfdsvy6ngj1NvbPI5bCE4DfMr53m6zdg7zHA/OxjYsVgkGZ6mmp9AdYR
         gnlYG3eKj1cbFgEJrKs+y/ifQndl/7jdxcksA6ZyDvnvB0ptVSOL8mI5/wNl5TIIZCQr
         kkIn9S+93uEe7phvawobD7GXH8YDsDCrjsu6ubRO4YfCD0Vq17bZ1QDCx9UWyEOT6ab3
         i6sJcQSr8KI0VyUFZPfQC0VVAEssE2QJMPIBwT5CuK2BGhScJ4zFMWcGrbXmwoovk9Ab
         OhOnUEFAKyjD4ZV8Q4+5RXTrS8X7c61GaFvLviA+kMeb2dBiEpQdhPK2U4kVqS/79xXF
         NsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773621834; x=1774226634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B4iLbVdU6UwNcjWJZqb9n6er3BcFb6HsfZvwCgpauBo=;
        b=MUpl1Be2kL0fMDUTMUguXcazMsxuEcJTliN9CXkz3MXqlaVXFKneEKQ7xSqmfqJNBt
         UFrRZ3lmAw5/aPGNW0580IjF2G+ybpJC2aCGzz3xdK5/g1CO69TV9K/wurFRIfjXtRgM
         dVNTaC2xNWAAOiOJndJ0fFChBHLxJtE1rg8GBN8ObHCWJ77if7vOftkIqjZdJEr6+38v
         eaqPcsxLoQ/PjAwtiEMvxjPG8nYsHeEaOJa/4neXsRN7zVNK+RqBqnZi3U3qXY2QkYgb
         xBjNAdOwr0RuMHXJUpsX/Cfi/l2ztg2cO3OSDxvkznGj+NpPqk2MJb8qmPTjW8nAdF43
         gekA==
X-Forwarded-Encrypted: i=1; AJvYcCWQQuWNntzpg9Q5ELJkw2JY4N46fd2WISSf5AwAcqZ4GaOjmQeSQ/CL88lalJJUMqxpyPkuWZE6tbA4lbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhUNgVNgqPm1u5cZ7AxPF0g+7getG4rZaNAoFyVEA0+r28DnKo
	3NFbdRfgQr4cIpeJN1lLZRvPJTMV6xUz4YO5T137KicJXgcID8F36V1YmUZL9kGOVYpGZ/fZIx6
	43pgY3rtPqFsabkY/CHzMhqXOqz2a2veH3EPI7xcK
X-Gm-Gg: ATEYQzyvEi4VuXP91YKsYNbCmsWNxIpcUsQ58feBtaIwTjR2p3COq3y41+O/Ae92joA
	fXv8YE9oWQjm5Vp7opiKmbGuzOl8CmRHkXHS1BqTvSNkxNu0fJCygGocLaKGlw3sluY3QvVlgxS
	Bwbka7zX4/gbpxuS5t7jm+CA1WWZAKtT5z/BVuoikDynANpiEXpmbx5lfLN1pTNq6fT4VBV9IE6
	USsJBR6UTU/g3D75jtZ6VDQnzI6aVn1sKplJGDVPdSgLOt8zgjEs6jm7AlSxV8u8Edbowclifoc
	CkHLaw==
X-Received: by 2002:ac8:590e:0:b0:503:4bc:c925 with SMTP id
 d75a77b69052e-5096aa2ae2cmr17578141cf.13.1773621833001; Sun, 15 Mar 2026
 17:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773346620.git.ljs@kernel.org> <52a7b9a003ea51521ab3c0baf30337a7800a3af7.1773346620.git.ljs@kernel.org>
In-Reply-To: <52a7b9a003ea51521ab3c0baf30337a7800a3af7.1773346620.git.ljs@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 15 Mar 2026 17:43:41 -0700
X-Gm-Features: AaiRm51H9IsCynzRpnxAc6_DrzYXD9cjd8fR558hmylwDQfMj5FrJzUnU5dorNw
Message-ID: <CAJuCfpHVN66abFrJgorXKBsjv7Ut=CP-E4NpLMC4SW613tJwtw@mail.gmail.com>
Subject: Re: [PATCH 03/15] mm: document vm_operations_struct->open the same as close()
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
	TAGGED_FROM(0.00)[bounces-9420-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,suse.com,google.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[surenb@google.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BA533293221
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 1:27=E2=80=AFPM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> Describe when the operation is invoked and the context in which it is
> invoked, matching the description already added for vm_op->close().
>
> While we're here, update all outdated references to an 'area' field for
> VMAs to the more consistent 'vma'.
>
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> ---
>  include/linux/mm.h | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index cc5960a84382..12a0b4c63736 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -748,15 +748,20 @@ struct vm_uffd_ops;
>   * to the functions called when a no-page or a wp-page exception occurs.
>   */
>  struct vm_operations_struct {
> -       void (*open)(struct vm_area_struct * area);
> +       /**
> +        * @open: Called when a VMA is remapped or split. Not called upon=
 first
> +        * mapping a VMA.

It's also called from dup_mmap() which is part of forking.

> +        * Context: User context.  May sleep.  Caller holds mmap_lock.
> +        */
> +       void (*open)(struct vm_area_struct *vma);
>         /**
>          * @close: Called when the VMA is being removed from the MM.
>          * Context: User context.  May sleep.  Caller holds mmap_lock.
>          */
> -       void (*close)(struct vm_area_struct * area);
> +       void (*close)(struct vm_area_struct *vma);
>         /* Called any time before splitting to check if it's allowed */
> -       int (*may_split)(struct vm_area_struct *area, unsigned long addr)=
;
> -       int (*mremap)(struct vm_area_struct *area);
> +       int (*may_split)(struct vm_area_struct *vma, unsigned long addr);
> +       int (*mremap)(struct vm_area_struct *vma);
>         /*
>          * Called by mprotect() to make driver-specific permission
>          * checks before mprotect() is finalised.   The VMA must not
> @@ -768,7 +773,7 @@ struct vm_operations_struct {
>         vm_fault_t (*huge_fault)(struct vm_fault *vmf, unsigned int order=
);
>         vm_fault_t (*map_pages)(struct vm_fault *vmf,
>                         pgoff_t start_pgoff, pgoff_t end_pgoff);
> -       unsigned long (*pagesize)(struct vm_area_struct * area);
> +       unsigned long (*pagesize)(struct vm_area_struct *vma);
>
>         /* notification that a previously read-only page is about to beco=
me
>          * writable, if an error is returned it will cause a SIGBUS */
> --
> 2.53.0
>


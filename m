Return-Path: <linux-hyperv+bounces-9422-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJT2GIBst2laRAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9422-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 03:35:44 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B93294285
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 03:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAB2E301DC2F
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 02:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591A3146A66;
	Mon, 16 Mar 2026 02:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Os005hha"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF421C862F
	for <linux-hyperv@vger.kernel.org>; Mon, 16 Mar 2026 02:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773628388; cv=pass; b=oRxYjmCxQSEIfvTLBPMzD01SH9pTKxBRDwh9DkOJz4qv6lyCnT9l8vm9sBqNbfMft4slUprLN9Jd6VDZGewPJWVzkWhwmt0Xl1YRrwB2PG6BTste0g3pAENtF381A+DTVB7u13yaLnQaYmhhyXzf/WBeEQxNMIvaAqNpF/cV8Hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773628388; c=relaxed/simple;
	bh=P8upWlYrnSKRURZkcwVOV+h6+eQ68h1jm6EnGvbVBq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWeBMN0bqY5AOvK2JaUy4FvL1WAM3qgJLXm3OHyZ6h524Mdi6jCDnqB7XbspD+GVsZnYGRvRKLzqPAs6HKAaSW1L4WFr4qij3IY2nBty2ZT5ANmBL6ZDjWS1mBuLU4YOOS4eFMWmVdPbcZXI3SAcKCzbnn22zNkilOAjx9g4bf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Os005hha; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-509062d829dso708971cf.1
        for <linux-hyperv@vger.kernel.org>; Sun, 15 Mar 2026 19:33:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773628385; cv=none;
        d=google.com; s=arc-20240605;
        b=JbZIpS1UtZ/ZYbMZsYnpRIBFaJ7bpbI8/lhFV8liwofqsryfftYI+nMGJDnxTOchKX
         aByDuZx7q6JgoZJTZ9HrV/lRd72Afgy7spVrsJcv04yi7iCpZEEFmaiMG/F6G/W1dRvf
         TA/ihX9CdSqM3kVC09sG7tLdUU1mDc7d9XSXQTDrA8HGZggnz+Cp1oHxW6KoArGLZct1
         EvbO0MLN3GlaovaXuLYaTKkvewjhcorhqD11zg+GStQQmiEc5srraowRNixguGE2Qsm6
         aKw5rp39xZu2oXynGKPsBnF80eUAkkvaSWeoe+CE212xEtFcnncR3hXvYS4z/tXkFQ7M
         ad6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SOxR7OMcrpIXquZYk6Fw42QRhAnf+JOcixO64waw3M8=;
        fh=Y13Gvfp2jA9jinx5RERwYTLhqjYVbxV2snAYp9yPxww=;
        b=Yu+mKAKkdq6lQ4S30AgPemPgcwFw7OthiY9oEG2Vuf/2RyFyB+14XFsQk+CDxejG7K
         Xc6sJM6KC+e5rFGwv0LDKSjHmFOeiQYFt9SAdd+gFq4/jtD5NMp06dmQN+XtgKBhetvO
         L3TAAsWpdTdMjdu/fcs1fFK1zd8KO5VXJZSWTvjz4e6h84tQQ2mdYaqkT3UywqU8fhoq
         k7mHgUWg/xmKOfbki+R16iMEZpDNPA1/MyIkZa9bYfTA8XRFQi0CJRXOZELLx6ALj96p
         ldSLUbBBKvOjSZqu95Rofbk+j5x3HcwphS2rcgsOAHTRu8GkdBdDkOSHKGXA2ZknaGzM
         I7dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773628385; x=1774233185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOxR7OMcrpIXquZYk6Fw42QRhAnf+JOcixO64waw3M8=;
        b=Os005hha9utJ0zhLJOYe43DqwRJu1UsmQb6s+HI6U/vIkdMMHKNfni2DnM3UjY2ppG
         Pgldse+NU/KSqsNIKnhLsbu3tV+y5WOf7u38Ae1jXCGJ+TALOgC7DlZBap+ebz4BPH5E
         nRNEReY023lXBY4rnzTVP/LQogEO2pekM5ob8tnZjzH8wkHt+SD0VxbFEmVw/IXm5ykT
         zenhaSk0a2HdP0Y9lApDdeu+NjIkaHvZvyqrN9+GDogwYjuU+8lnmWqykOgeBlgiP6JA
         /7T3vubRR+T2OKrdyYplaKBWP4WvlYGo8Iw+KD28NlBJmyFbtK2bzcP1n+j5ThCSE+rA
         UXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773628385; x=1774233185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SOxR7OMcrpIXquZYk6Fw42QRhAnf+JOcixO64waw3M8=;
        b=D5ULT5o7v1JzZTx472oJbYYhcElVrKQHCodWLg8Ebxp+joEQWyCdbr64XSzak+5mIL
         11WOCbyVcZZ8uaEUyRVKpgOKaL+5PLDEygFRSDm30Knc3Ao5nY8FgiMZ6e99SIEQuKsl
         4GOTSsITAkwZKTNeLvDpNM/CtXGSG+NZFXT5QwV9uoleJzpqOUr3oy02Cr1SA9vJHJii
         u1cb17Bnv1v1jRvIB41nF8hrxeobBRnFKEDwuxei27e4W6mHMljtVIFUoLP7Pqa27DbG
         dspF6KjMm8GBWcWcSP65WF2x03fDJqVrCZGbu/6V0bZhKmRjODM8sAwj8oIy9YexGhrP
         j1fg==
X-Forwarded-Encrypted: i=1; AJvYcCWFag8uSnvHwzMhQ+EGczBXIsfhtCrQ7Q7OP8eIdjTejEq3L6lJDoJhNe1p0l/alZoPB/lyfWq5StwKed0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNdAFKDPTtwY+qD2o0moDRskvhFCWaZP2CPbv52S5kdGswNGYr
	8LlFjeJVOFaYS7lvQ6KIoZ9busWK93JRZB12jFUutMAUx3e/Srvt+T2xjorzx6ImPZ5D01tQE6K
	UpumfT1aETgsz7oQ3kNqMnPiIMa/ocSNmy9MItqTB
X-Gm-Gg: ATEYQzyc1aVHi/J2CTCQjRxMi8fNLf6JYM9y9MEy++7vTyUFdNJHNhoHqtkdRRGqhCe
	LkmYl3yzQ71uMgS9WjVnJgnAGNFelVrmW937eDkM64K3eMdarwtSqVB/XywIvd48kaBNREaMcvP
	ZevF3k7WCEHv2BzBN1cb+NutZ6PcHZJhTbvLqtSzC21a5kBhvqYNN+dzuJhZyaKkvYvPJMSwjtm
	X8RMQil7SDuSgLoNNtlwOejxpF9SxBxS4hF+UwawnBja+uFeNZsWpv3F/0vs3mSruAukeyv9GsC
	nwvohA==
X-Received: by 2002:a05:622a:60c:b0:4fb:e3b0:aae6 with SMTP id
 d75a77b69052e-5096a92ebdbmr823271cf.1.1773628384887; Sun, 15 Mar 2026
 19:33:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4a5fa45119220b9d99ed72a36308aed01a30d2c1.1773346620.git.ljs@kernel.org>
 <20260313110745.2573005-1-usama.arif@linux.dev> <c62305d7-22c4-4cf7-969b-fbe214c93b64@lucifer.local>
In-Reply-To: <c62305d7-22c4-4cf7-969b-fbe214c93b64@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 15 Mar 2026 19:32:54 -0700
X-Gm-Features: AaiRm52_478_pqzpMaMH6nJQtQvcaF-xKuK5uDWZ-u00xGMYRYKMJPl6M-Q1q5E
Message-ID: <CAJuCfpFio6n-O-1NkPXrymV0o3UqvHYS8ZOyQtt=JXnZ5dTGhQ@mail.gmail.com>
Subject: Re: [PATCH 05/15] fs: afs: correctly drop reference count on mapping failure
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Usama Arif <usama.arif@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9422-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	FREEMAIL_CC(0.00)[linux.dev,linux-foundation.org,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,suse.com,google.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[surenb@google.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 23B93294285
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 5:00=E2=80=AFAM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> On Fri, Mar 13, 2026 at 04:07:43AM -0700, Usama Arif wrote:
> > On Thu, 12 Mar 2026 20:27:20 +0000 "Lorenzo Stoakes (Oracle)" <ljs@kern=
el.org> wrote:
> >
> > > Commit 9d5403b1036c ("fs: convert most other generic_file_*mmap() use=
rs to
> > > .mmap_prepare()") updated AFS to use the mmap_prepare callback in fav=
our of
> > > the deprecated mmap callback.
> > >
> > > However, it did not account for the fact that mmap_prepare can fail t=
o map
> > > due to an out of memory error, and thus should not be incrementing a
> > > reference count on mmap_prepare.

This is a bit confusing. I see the current implementation does
afs_add_open_mmap() and then if generic_file_mmap_prepare() fails it
does afs_drop_open_mmap(), therefore refcounting seems to be balanced.
Is there really a problem?

> > >
> > > With the newly added vm_ops->mapped callback available, we can simply=
 defer
> > > this operation to that callback which is only invoked once the mappin=
g is
> > > successfully in place (but not yet visible to userspace as the mmap a=
nd VMA
> > > write locks are held).
> > >
> > > Therefore add afs_mapped() to implement this callback for AFS.
> > >
> > > In practice the mapping allocations are 'too small to fail' so this i=
s
> > > something that realistically should never happen in practice (or woul=
d do
> > > so in a case where the process is about to die anyway), but we should=
 still
> > > handle this.

nit: I would drop the above paragraph. If it's impossible why are you
handling it? If it's unlikely, then handling it is even more
important.

> > >
> > > Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> > > ---
> > >  fs/afs/file.c | 20 ++++++++++++++++----
> > >  1 file changed, 16 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/fs/afs/file.c b/fs/afs/file.c
> > > index f609366fd2ac..69ef86f5e274 100644
> > > --- a/fs/afs/file.c
> > > +++ b/fs/afs/file.c
> > > @@ -28,6 +28,8 @@ static ssize_t afs_file_splice_read(struct file *in=
, loff_t *ppos,
> > >  static void afs_vm_open(struct vm_area_struct *area);
> > >  static void afs_vm_close(struct vm_area_struct *area);
> > >  static vm_fault_t afs_vm_map_pages(struct vm_fault *vmf, pgoff_t sta=
rt_pgoff, pgoff_t end_pgoff);
> > > +static int afs_mapped(unsigned long start, unsigned long end, pgoff_=
t pgoff,
> > > +                 const struct file *file, void **vm_private_data);
> > >
> > >  const struct file_operations afs_file_operations =3D {
> > >     .open           =3D afs_open,
> > > @@ -61,6 +63,7 @@ const struct address_space_operations afs_file_aops=
 =3D {
> > >  };
> > >
> > >  static const struct vm_operations_struct afs_vm_ops =3D {
> > > +   .mapped         =3D afs_mapped,
> > >     .open           =3D afs_vm_open,
> > >     .close          =3D afs_vm_close,
> > >     .fault          =3D filemap_fault,
> > > @@ -500,13 +503,22 @@ static int afs_file_mmap_prepare(struct vm_area=
_desc *desc)
> > >     afs_add_open_mmap(vnode);
> >
> > Is the above afs_add_open_mmap an additional one, which could cause a r=
eference
> > leak? Does the above one need to be removed and only the one in afs_map=
ped()
> > needs to be kept?
>
> Ah yeah good spot, will fix thanks!
>
> >
> > >
> > >     ret =3D generic_file_mmap_prepare(desc);
> > > -   if (ret =3D=3D 0)
> > > -           desc->vm_ops =3D &afs_vm_ops;
> > > -   else
> > > -           afs_drop_open_mmap(vnode);
> > > +   if (ret)
> > > +           return ret;
> > > +
> > > +   desc->vm_ops =3D &afs_vm_ops;
> > >     return ret;
> > >  }
> > >
> > > +static int afs_mapped(unsigned long start, unsigned long end, pgoff_=
t pgoff,
> > > +                 const struct file *file, void **vm_private_data)
> > > +{
> > > +   struct afs_vnode *vnode =3D AFS_FS_I(file_inode(file));
> > > +
> > > +   afs_add_open_mmap(vnode);
> > > +   return 0;
> > > +}
> > > +
> > >  static void afs_vm_open(struct vm_area_struct *vma)
> > >  {
> > >     afs_add_open_mmap(AFS_FS_I(file_inode(vma->vm_file)));
> > > --
> > > 2.53.0
> > >
> > >
>
> Cheers, Lorenzo


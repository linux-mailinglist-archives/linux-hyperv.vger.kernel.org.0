Return-Path: <linux-hyperv+bounces-9479-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLKpCIjOuGlfjgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9479-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 04:46:16 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B40B2A34FC
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 04:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF1F7303A85E
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 03:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623F730ACE3;
	Tue, 17 Mar 2026 03:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cyh2ZdDD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7643093CB
	for <linux-hyperv@vger.kernel.org>; Tue, 17 Mar 2026 03:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773718925; cv=pass; b=gVEWK0bJh1gyg7KON45tw0qNBJW4vBjdAf2x5tpXAdMiAoc/2L0RitN5I22tbzqK+gEuT4UjiaJ3Mn9wVjprHY+KN/4LSxH7NkdJRldCMpOspZ8uR6MUzDWYa2hW4kryBp93ZUfoQ2ZmTGTxZ2gFN2J/H9yNDQwJF9MjWI/fi88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773718925; c=relaxed/simple;
	bh=WMHI6RHUC26ebl9/TVkwR2rJeC5kBjFPfSnTY/Oar1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oTD5Mus+yk5kWz96nN+BWBbTyXx2kmXccwwDQ57qwn08sZp4FoGcln94XlHH2ipY1j5xJJ5S2ZFMuLwNA26B5heorq8F44Q1j2qZE4dDWdxOhqVm9RyglOgh4JiqlDLH8iDCzw+/+9fZ3iTLIaCr7vvGuUKexJdHWG+Zzhfr8yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cyh2ZdDD; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-661169cd6d8so3749a12.1
        for <linux-hyperv@vger.kernel.org>; Mon, 16 Mar 2026 20:42:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773718922; cv=none;
        d=google.com; s=arc-20240605;
        b=Sz7qYcm3ir3D4oT4Vco5Dk7jOPw76BZVJsQH6SkkQEoQN2AwPq9A9q3B4kaXpp1iVA
         fqPkSigeqezIr3FJgJrCQ9h+TZEvnmJWZz5FbToHYKrickvdGt+ROwEo9icbXsh11auR
         auii0jhhvCoUgNYBizfTOn6EjFMJDwMi724OV/cLXGzOQTCovuhAcKoouXABoNt1V1d+
         aNT0tvBfaLPLreKwMZ5LCCZzeTJLrfJ2cI0ID7DmHh7L4cY2DkjTqepzQ6xjO4Tdd+Xs
         lBUQaxyog9GYth+fHyz65UDTUCoE0fNbLm/EL5gxaSNjUBtz94uP7JiesBal8JcBTbrt
         zSlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SDjcbstE7vaBgKzikVP/a05WleFr4Bi6N01Q1DpO7Ng=;
        fh=d2WMVStFL3RPnU/xsjHlJrKFynEsTKtOOeKdQKhvhgM=;
        b=e+foOHIHA8s3tM7SqGBC0eshDeAhLd8aPRJ3eHyCX6GYuJec+ncNF2b1kLnmik8sI8
         qnbbYWuWtF7fsp9lz9+yDi4dwpb/HhBjfezhK8Qpx8PQdyZb7fuBItUZoPtc0Mies3dP
         MSg2xHOK3j5Y3gpQS2VdmgNbs4jglEfa4DNYUQGC7/zDRPwLUMrP/xgj5ZLNNGL07P7k
         SiPsYWDj1BTN0TGGxMozr/tHoBst1xMp1qsJnnwVJ4vDioAD8BBU6VHItmpdVmwyaFpP
         UoRgMSakhKB+TdpQoyw468s1ctWM56tGYJQxL3Ve9EuJ8Gh5F9k7JFSqzsgwfdkVZ8do
         sOFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773718922; x=1774323722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDjcbstE7vaBgKzikVP/a05WleFr4Bi6N01Q1DpO7Ng=;
        b=cyh2ZdDD25f0Dcfzqn0/fTS1Bga/5Iu+bb9UdhDFPQNIA51BZAHkfSliATWdhbLUcl
         sOHWrtsy2Cd9yl38Ox6btyowj5g2gHJJzLJfanN+CYAsvcO/BImZK3+yFQPksOjSst4R
         YxA2YDu31NoFKwMCouBzhi/5/N2cQnY2vq8vFHjQL9NAz2wwweLtbyQOhm+5PUrmrNSj
         BO3N70T5CON4JQc/JPoQpRwgCSEZzGNqswZuC7HmiGpZDUrc5OgCugAY8jwCrbtSx5KZ
         dD0f45YCU5fBS++odpfk/GilBzxm1tK6oo7rcHXQCq2IL1OYuGHmm9w1/6V7ar73F5yT
         DH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773718922; x=1774323722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SDjcbstE7vaBgKzikVP/a05WleFr4Bi6N01Q1DpO7Ng=;
        b=ooSli+QugEVKLetjQqfID1WQox9f8idYOynYYjREvcFGnVesdWyR8GZJ0eNgQ7mv1n
         qY1hUKqwl+aXXj8iGl8R9AikaPSJLniG63jp++5N0apB0aS8fcCtR+tYyoskfGsExMQS
         V1Amf52Fkg7aIxmjFjVH6XDtOdbmIeIkRYS/taE6I1mhwHhmenwy9rD1UnFW4EjyYdjA
         TKMY3ZnZ3ZYnxJP44kEcgnCn7PSGr4vlG/4xEI0dR3Y9ZEC83eg2zk01qksZH41dug/5
         ZvsCtoA4eeTlMjInjkE0BbFcH6lpvpA9FaypPPGV4r3IarnwWGySKBgXApuuf9/IKGBX
         sEfw==
X-Forwarded-Encrypted: i=1; AJvYcCWnnmawqMH5Eynxv6iZ3iiJBe9z35r73t8BTz/15WTnqBnpi42oYojfUNJ+CHnhG6u9nhC0UEkOiOhiJvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3mjoJrUa6aKaDMuzqCSjT7Ssl9duUFVJiaWi6i6c7BOEorXHP
	0YVc+6eSf65t9ugfIjNfO8rY/3U5ObZ+JpZTzfVU1s2WxlsBBLqvRjdDJCAJ4V4lw6wUufitAJm
	wc0lRePE3JFT7XiCQe4KPJrVUr8YGvTDfaMtQRtJb
X-Gm-Gg: ATEYQzyxX1Pfcm+e6D1zdt3F7gom1os8kP3qDEekdKrMknom9KiRjdjrjzbjZdd/h6c
	VIVxXosEdIqwApByBIVo8RMvEeLtIQ/PIBD/BPVNZCOsCFcgVbM5OsWUfKt+gZTfIhzNG8xpGTr
	vz2ySupoEq08DHs2bxfL8slrGNZrAoNlumuk4kXqXPUBEkDAZC0Z4bB17XI2ITgZnVV/MBnFJaI
	T8VHBdmWq0VfbrHgHxJX5JNJhz9nuCfkKqZ25HjAyH4nk98iERwtupb3cQddMHBaAr5hv10dK6P
	9bVNuA==
X-Received: by 2002:a05:6402:5047:b0:667:926:56e with SMTP id
 4fb4d7f45d1cf-6671449f938mr28406a12.2.1773718921655; Mon, 16 Mar 2026
 20:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4a5fa45119220b9d99ed72a36308aed01a30d2c1.1773346620.git.ljs@kernel.org>
 <20260313110745.2573005-1-usama.arif@linux.dev> <c62305d7-22c4-4cf7-969b-fbe214c93b64@lucifer.local>
 <CAJuCfpFio6n-O-1NkPXrymV0o3UqvHYS8ZOyQtt=JXnZ5dTGhQ@mail.gmail.com> <2536c05e-e228-404f-9916-906c0447b114@lucifer.local>
In-Reply-To: <2536c05e-e228-404f-9916-906c0447b114@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 16 Mar 2026 20:41:48 -0700
X-Gm-Features: AaiRm51L9yY6IK4TcJFLhN8NGwQS7Z64sx0O9EJzSXirWOtaRRhN6Ww7XVogluY
Message-ID: <CAJuCfpH2XyAJOFKCZnviVV_UbF4O0wzj3QgJieo+LD=Cvr71jA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9479-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B40B2A34FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 7:29=E2=80=AFAM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> On Sun, Mar 15, 2026 at 07:32:54PM -0700, Suren Baghdasaryan wrote:
> > On Fri, Mar 13, 2026 at 5:00=E2=80=AFAM Lorenzo Stoakes (Oracle) <ljs@k=
ernel.org> wrote:
> > >
> > > On Fri, Mar 13, 2026 at 04:07:43AM -0700, Usama Arif wrote:
> > > > On Thu, 12 Mar 2026 20:27:20 +0000 "Lorenzo Stoakes (Oracle)" <ljs@=
kernel.org> wrote:
> > > >
> > > > > Commit 9d5403b1036c ("fs: convert most other generic_file_*mmap()=
 users to
> > > > > .mmap_prepare()") updated AFS to use the mmap_prepare callback in=
 favour of
> > > > > the deprecated mmap callback.
> > > > >
> > > > > However, it did not account for the fact that mmap_prepare can fa=
il to map
> > > > > due to an out of memory error, and thus should not be incrementin=
g a
> > > > > reference count on mmap_prepare.
> >
> > This is a bit confusing. I see the current implementation does
> > afs_add_open_mmap() and then if generic_file_mmap_prepare() fails it
> > does afs_drop_open_mmap(), therefore refcounting seems to be balanced.
> > Is there really a problem?
>
> Firstly, mmap_prepare is invoked before we try to merge, so the VMA could=
 in
> theory get merged and then the refcounting will be wrong.

I see now. Ok, makes sense.

>
> Secondly, mmap_prepare occurs at such at time where it is _possible_ that
> allocation failures as described below could happen.

Right, but in that case afs_file_mmap_prepare() would drop its
refcount and return an error, so refcounting is still good, no?

>
> I'll update the commit message to reflect the merge aspect actually.

Thanks!

>
> >
> > > > >
> > > > > With the newly added vm_ops->mapped callback available, we can si=
mply defer
> > > > > this operation to that callback which is only invoked once the ma=
pping is
> > > > > successfully in place (but not yet visible to userspace as the mm=
ap and VMA
> > > > > write locks are held).
> > > > >
> > > > > Therefore add afs_mapped() to implement this callback for AFS.
> > > > >
> > > > > In practice the mapping allocations are 'too small to fail' so th=
is is
> > > > > something that realistically should never happen in practice (or =
would do
> > > > > so in a case where the process is about to die anyway), but we sh=
ould still
> > > > > handle this.
> >
> > nit: I would drop the above paragraph. If it's impossible why are you
> > handling it? If it's unlikely, then handling it is even more
> > important.
>
> Sure I can drop it, but it's an ongoing thing with these small allocation=
s.
>
> I wish we could just move to a scenario where we can simpy assume allocat=
ions
> will always succeed :)

That would be really nice but unfortunately the world is not that
perfect. I just don't want to be chasing some rarely reproducible bug
because of the assumption that an allocation is too small to fail.

>
> Vlasta - thoughts?
>
> Cheers, Lorenzo
>
> >
> > > > >
> > > > > Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> > > > > ---
> > > > >  fs/afs/file.c | 20 ++++++++++++++++----
> > > > >  1 file changed, 16 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/fs/afs/file.c b/fs/afs/file.c
> > > > > index f609366fd2ac..69ef86f5e274 100644
> > > > > --- a/fs/afs/file.c
> > > > > +++ b/fs/afs/file.c
> > > > > @@ -28,6 +28,8 @@ static ssize_t afs_file_splice_read(struct file=
 *in, loff_t *ppos,
> > > > >  static void afs_vm_open(struct vm_area_struct *area);
> > > > >  static void afs_vm_close(struct vm_area_struct *area);
> > > > >  static vm_fault_t afs_vm_map_pages(struct vm_fault *vmf, pgoff_t=
 start_pgoff, pgoff_t end_pgoff);
> > > > > +static int afs_mapped(unsigned long start, unsigned long end, pg=
off_t pgoff,
> > > > > +                 const struct file *file, void **vm_private_data=
);
> > > > >
> > > > >  const struct file_operations afs_file_operations =3D {
> > > > >     .open           =3D afs_open,
> > > > > @@ -61,6 +63,7 @@ const struct address_space_operations afs_file_=
aops =3D {
> > > > >  };
> > > > >
> > > > >  static const struct vm_operations_struct afs_vm_ops =3D {
> > > > > +   .mapped         =3D afs_mapped,
> > > > >     .open           =3D afs_vm_open,
> > > > >     .close          =3D afs_vm_close,
> > > > >     .fault          =3D filemap_fault,
> > > > > @@ -500,13 +503,22 @@ static int afs_file_mmap_prepare(struct vm_=
area_desc *desc)
> > > > >     afs_add_open_mmap(vnode);
> > > >
> > > > Is the above afs_add_open_mmap an additional one, which could cause=
 a reference
> > > > leak? Does the above one need to be removed and only the one in afs=
_mapped()
> > > > needs to be kept?
> > >
> > > Ah yeah good spot, will fix thanks!
> > >
> > > >
> > > > >
> > > > >     ret =3D generic_file_mmap_prepare(desc);
> > > > > -   if (ret =3D=3D 0)
> > > > > -           desc->vm_ops =3D &afs_vm_ops;
> > > > > -   else
> > > > > -           afs_drop_open_mmap(vnode);
> > > > > +   if (ret)
> > > > > +           return ret;
> > > > > +
> > > > > +   desc->vm_ops =3D &afs_vm_ops;
> > > > >     return ret;
> > > > >  }
> > > > >
> > > > > +static int afs_mapped(unsigned long start, unsigned long end, pg=
off_t pgoff,
> > > > > +                 const struct file *file, void **vm_private_data=
)
> > > > > +{
> > > > > +   struct afs_vnode *vnode =3D AFS_FS_I(file_inode(file));
> > > > > +
> > > > > +   afs_add_open_mmap(vnode);
> > > > > +   return 0;
> > > > > +}
> > > > > +
> > > > >  static void afs_vm_open(struct vm_area_struct *vma)
> > > > >  {
> > > > >     afs_add_open_mmap(AFS_FS_I(file_inode(vma->vm_file)));
> > > > > --
> > > > > 2.53.0
> > > > >
> > > > >
> > >
> > > Cheers, Lorenzo


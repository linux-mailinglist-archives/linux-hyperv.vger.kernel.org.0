Return-Path: <linux-hyperv+bounces-10754-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCJDBm72AWoFmwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10754-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 17:31:58 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E78511355
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 17:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E25D300DED7
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 15:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A7E3BD241;
	Mon, 11 May 2026 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dE1TL1e6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7163A4F23;
	Mon, 11 May 2026 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513394; cv=none; b=K89tybomlZvgt8AtgodTnaU46f+WIFKeBDd7L/kx8OpTfDO5sv8okbUcOJH3bdqJvidQYLjvivjMOrSUzAOPx92Ci4tnX2QitfqeJ00qDnlIAu5Ruphwo93WAUVayiZQW7Niphbiv2kwFofTzItrkUfdEFq5/jGw/9flfvMq7h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513394; c=relaxed/simple;
	bh=s1LXttIPqCFQe18mSLm8MNVRGZSEpy2RpU++pXlqPzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKweCUtQ6Z97ynhZlvQd4p9pL1LktcEpLUYubkmWw5kf/asX7wvWJ4P6ND4pEr+lF6QY7AnxYxFdSOMmFRSv68SPCs22wjRankNed3KmogXcoRYIxFhrGcyPIw83IahkjEmhXSBie9QmHhjpc+SkVJuyeJU8eV+m3GMNVkvbR3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dE1TL1e6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8F7BC20B7166;
	Mon, 11 May 2026 08:29:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8F7BC20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778513390;
	bh=mCxyvjjPET1g+z75OVk+RSJlhC7s0ZmG7Ymn5HKYFzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dE1TL1e6REpfAQVnxbiSZPlNdSOQFQXukJru8Fgg+usazMsAARMaS2fhoyqz4Jlry
	 N6oXQ/u/NN7hpetgh6GCsJ0E5UtNDo0qgYV/lx7RnVzsbC6REP+Zn2rwKbvWkkce5r
	 NrwaDC1zm0w2guYcuovjD1370qN245uTd/SgflKs=
Date: Mon, 11 May 2026 08:29:50 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 17/18] mshv: Publish VP to pt_vp_array before
 installing the file descriptor
Message-ID: <agH17u_h2ljX5sUb@skinsburskii.localdomain>
References: <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177816867231.21765.15171005242069873878.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <20260511-warping-determined-kagu-eb5fcd@anirudhrb>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511-warping-determined-kagu-eb5fcd@anirudhrb>
X-Rspamd-Queue-Id: A9E78511355
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10754-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 02:26:45PM +0000, Anirudh Rayabharam wrote:
> On Thu, May 07, 2026 at 03:44:32PM +0000, Stanislav Kinsburskii wrote:
> > mshv_partition_ioctl_create_vp() called anon_inode_getfd() before
> > publishing the new VP into partition->pt_vp_array.  anon_inode_getfd()
> > includes fd_install(), so the fd was live in current->files before the
> > publish ran.
> > 
> > A concurrent MSHV_RUN_VP ioctl on that fd does not serialise against the
> > in-progress MSHV_CREATE_VP — it takes vp->vp_mutex, not the partition
> > mutex.  Once the VP starts running and traps, mshv_intercept_isr() can look
> > up partition->pt_vp_array[vp_index] and observe NULL, silently dropping the
> > intercept message.
> > 
> > Split the fd creation: reserve an fd with get_unused_fd_flags(), create the
> > file with anon_inode_getfile(), publish the VP via smp_store_release(), and
> > finally call fd_install() as the userspace-visibility commit point.
> > 
> > Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/mshv_root_main.c |   29 ++++++++++++++++++++++-------
> >  1 file changed, 22 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> > index e32f6e0f9f637..1c18d1c1f7947 100644
> > --- a/drivers/hv/mshv_root_main.c
> > +++ b/drivers/hv/mshv_root_main.c
> > @@ -1142,6 +1142,8 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
> >  	struct mshv_vp *vp;
> >  	struct page *intercept_msg_page, *register_page, *ghcb_page;
> >  	struct hv_stats_page *stats_pages[2];
> > +	struct file *file;
> > +	int fd;
> >  	long ret;
> >  
> >  	if (copy_from_user(&args, arg, sizeof(args)))
> > @@ -1214,14 +1216,18 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
> >  	if (ret)
> >  		goto put_partition;
> >  
> > -	/*
> > -	 * Keep anon_inode_getfd last: it installs fd in the file struct and
> > -	 * thus makes the state accessible in user space.
> > -	 */
> > -	ret = anon_inode_getfd("mshv_vp", &mshv_vp_fops, vp,
> > -			       O_RDWR | O_CLOEXEC);
> 
> Why not just move this anon_inode_getfd() after the smp_store_release()
> call?
> 

Because anon_inode_getfd() can still fail at the fd-table step after the
VP is already visible to lockless ISR readers, and unpublishing it would
require a grace-period wait under pt_mutex while ISRs may have already
observed and acted on the doomed VP. The split form keeps every failable
step before the publish, so failure paths stay simple and the publish
itself cannot fail.

Thanks,
Stanislav


> Thanks,
> Anirudh.


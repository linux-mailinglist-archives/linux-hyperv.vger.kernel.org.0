Return-Path: <linux-hyperv+bounces-10386-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKJwMBpP72kEAAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10386-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 13:57:14 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC7F472267
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 13:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 015993051E94
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 11:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670FE39A04D;
	Mon, 27 Apr 2026 11:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VnsXT5KP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2B9388E72;
	Mon, 27 Apr 2026 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777290696; cv=none; b=jgEPok+TJew+cbJdALG3oFrXUhXsgqJLOwahkYuDEPf8+IhTbPrZqOP2LUDlNSeR0Pk6xS445e5gujP7HkgibjEFiVfw4+gZdhHWXw68dYfz0QbttDpNF4ukrx2ZnEJ9rGEHPvDjM7do9ArgEC6oPoHX5eD5G9BgEAYgY+FdYWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777290696; c=relaxed/simple;
	bh=55NqU6/Q4ArQrCtOYDO2EVlZcJ5uLmdn3BrT5kwTOPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOkI+prPi8dKQKcjpDQSnFWfhG7rtNTfXJjd4EVsezFdAA4zFbSKrtyPFLqBso13CnJAHC3kMhnop5tSgcv87TlL8GU2zmKx8RciTPVE5hmMkt+XmIIX1pE6W7dkOAD26kgGYFPC9aRekqEAZ7wj+8SsvuS3AKML79fHSUeQWLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VnsXT5KP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 8D55F20B7169; Mon, 27 Apr 2026 04:51:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8D55F20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777290694;
	bh=u4fxCSX6+lkya8NkULSrVpIHMRpwmUGWqwp1lb66MDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VnsXT5KPDTqb3PGZqTBaTFbTzX+ByVQgClsT65WKGJG2JZC9V16fL6Y4yQ78sHfFD
	 B2ElV/SkAyffzpDCAWB9kzh+7kGOpd1z5oLvqvzzJbHPPokS4jV8EoCZ/9g9tJELoN
	 GiJkCIdmaFtrl4gV4aiOAtcpa0RDwdJb6K967djY=
Date: Mon, 27 Apr 2026 04:51:34 -0700
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Saurabh Singh Sengar <ssengar@microsoft.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Himadri Pandya <himadrispandya@gmail.com>,
	Michael Kelley <mhklinux@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Deepak Rawat <drawat.floss@gmail.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"stable@kernel.vger.org" <stable@kernel.vger.org>
Subject: Re: [PATCH 2/2] drm/hyperv: use VMBUS_RING_SIZE()
Message-ID: <ae9NxmDBTkzPP3H6@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260425181719.1538483-1-hamzamahfooz@linux.microsoft.com>
 <20260425181719.1538483-2-hamzamahfooz@linux.microsoft.com>
 <KUZP153MB14445757C6A5DA5DEDA9A09CBE292@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <KUZP153MB14445757C6A5DA5DEDA9A09CBE292@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
X-Rspamd-Queue-Id: 2AC7F472267
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10386-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microsoft.com,kernel.org,redhat.com,davemloft.net,google.com,gmail.com,outlook.com,lists.linux.dev,linux.microsoft.com,linux.intel.com,suse.de,ffwll.ch,lists.freedesktop.org,kernel.vger.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hamzamahfooz@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.org:email,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]

On Sun, Apr 26, 2026 at 05:00:24AM +0000, Saurabh Singh Sengar wrote:
> > Subject: [PATCH 2/2] drm/hyperv: use VMBUS_RING_SIZE()
> > 
> > VMBUS ring buffers must be page aligned. So, use VMBUS_RING_SIZE() to
> > ensure they are always aligned and large enough to hold all of the relevant
> > data.
> > 
> > Cc: stable@kernel.vger.org
> > Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic video
> > device")
> > Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> > ---
> >  drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> > b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> > index 051ecc526832..753d97bff76f 100644
> > --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> > +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> > @@ -10,7 +10,7 @@
> > 
> >  #include "hyperv_drm.h"
> > 
> > -#define VMBUS_RING_BUFSIZE (256 * 1024)
> > +#define VMBUS_RING_BUFSIZE VMBUS_RING_SIZE(256 * 1024)
> >  #define VMBUS_VSP_TIMEOUT (10 * HZ)
> > 
> >  #define SYNTHVID_VERSION(major, minor) ((minor) << 16 | (major))
> > --
> > 2.54.0
> 
> Although this lgtm, but this may change the behaviour on ARM64 systems with page size > 4K ?
> Have we tested it ?

Yup, I tested it on an ARM64 windows machine with a 64K page size guest kernel.

> 
> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Pushed to drm-misc.

> 


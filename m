Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC8C2EA983
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Jan 2021 12:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbhAELGM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Jan 2021 06:06:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58294 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728175AbhAELGM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Jan 2021 06:06:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609844686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9l0tND+UxcCMLDlOD7Ol3zZinY+fs8qgyUo+4LEabfk=;
        b=NuvpSWhT7Iu7Tbn2x3soeN2+Br01T1W1HCEtWx3S2egnPAk1X0WiEJuT1InECaEmMuLCp4
        vVuuJgWOu1/K6im1bWAwnSUYuPNTRhuaTAwGksVPaDOX+TgHAn5PjK0eJFMsVWJ+ZnqGOZ
        k0akgPIDYKFpDKHhq8hUSMLw6XNECwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-p0Bee2lZNj-8jO8rBHNv6A-1; Tue, 05 Jan 2021 06:04:44 -0500
X-MC-Unique: p0Bee2lZNj-8jO8rBHNv6A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05435107ACE3;
        Tue,  5 Jan 2021 11:04:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-209.ams2.redhat.com [10.36.114.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FA0F5D9CC;
        Tue,  5 Jan 2021 11:04:41 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 3994A1800099; Tue,  5 Jan 2021 12:04:38 +0100 (CET)
Date:   Tue, 5 Jan 2021 12:04:38 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Deepak Rawat <drawat.floss@gmail.com>,
        linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Dexuan Cui <decui@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        Tang Shaofeng <shaofeng.tang@intel.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH 1/2] drm/hyperv: Add DRM driver for hyperv synthetic
 video device
Message-ID: <20210105110438.zhy22zzqfgbnonos@sirius.home.kraxel.org>
References: <20210102060336.832866-1-drawat.floss@gmail.com>
 <2b49fcd2-38f7-dae5-2992-721a8bd142a2@suse.de>
 <4f7818f99734c0912325e1f3b6b80cb2a04df3ef.camel@gmail.com>
 <ec340e8e-6386-d582-c93b-0a35c60f9dca@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec340e8e-6386-d582-c93b-0a35c60f9dca@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

  Hi,

> > It's not possible to do page flip with this virtual device. The call to
> > SYNTHVID_VRAM_LOCATION is only honoured once. So unfortunately need to
> > use SHMEM helpers.
> 
> I was thinking about using struct video_output_situation.vram_offset; in
> case you want to tinker with that. There's a comment in the patch that
> vram_offset should always be 0. But this comment seems incorrect for devices
> with more than one output.

Where does the comment come from?  fbdev drivers support a single
framebuffer only so for a fbdev driver it makes sense to set the offset
to 0 unconditionally.  With drm you probably can handle things
differently ...

take care,
  Gerd


Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E70744C15E
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Nov 2021 13:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhKJMhB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 10 Nov 2021 07:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhKJMhA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 10 Nov 2021 07:37:00 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742F8C061764
        for <linux-hyperv@vger.kernel.org>; Wed, 10 Nov 2021 04:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202012; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xun289VLWWZ82saKfNnf5+f3tJJ0jkNDF5lxfzbWlmM=; b=QFuXmqRSBOQITyzJYF6V1YmiS0
        h2SeY3zlP8LbZEBribxQij+PUF98b77082ErPi+XFtV9WTx8Lm2caNKvwYBlmMrEGX1Do3ySBaQJK
        78Ae91Xix1ZRqgoxdADS7DupOSZCrsdJfztx6U5sBqa5ub5sGLciU8kdCxIETfHBvpAarGnXSoCzh
        1NKMZD8Uo75gKvsoBj7jhkAThGCO7SD24bkCC7ojIdSKEIcBKeHDdb6BYWsGm8O40Gx5k7Z3CMADk
        MpPiel7BDPK3RsZqvq1UN9WlgNgGcVJpp6L/3iUgN0BySvFRynZNTfngQOUe61KMN5PgoS6HwF5BC
        87oT5RGg==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:52473 helo=[192.168.10.61])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1mkmnq-0005OW-GL; Wed, 10 Nov 2021 13:34:10 +0100
Subject: Re: [PATCH v3 7/9] drm/simpledrm: Enable FB_DAMAGE_CLIPS property
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, drawat.floss@gmail.com,
        airlied@redhat.com, kraxel@redhat.com, david@lechnology.com,
        sam@ravnborg.org, javierm@redhat.com, kernel@amanoeldawod.com,
        dirty.ice.hu@gmail.com, michael+lkml@stapelberg.ch, aros@gmx.com,
        joshua@stroblindustries.com, arnd@arndb.de
Cc:     dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20211110103702.374-1-tzimmermann@suse.de>
 <20211110103702.374-8-tzimmermann@suse.de>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <0e762e67-b18f-3cbd-b401-d6766a7168a3@tronnes.org>
Date:   Wed, 10 Nov 2021 13:34:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211110103702.374-8-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



Den 10.11.2021 11.37, skrev Thomas Zimmermann:
> Enable the FB_DAMAGE_CLIPS property to reduce display-update
> overhead. Also fixes a warning in the kernel log.
> 
>   simple-framebuffer simple-framebuffer.0: [drm] drm_plane_enable_fb_damage_clips() not called
> 
> Fix the computation of the blit rectangle. This wasn't an issue so
> far, as simpledrm always blitted the full framebuffer. The code now
> supports damage clipping and virtual screen sizes.
> 
> v3:
> 	* fix drm_dev_enter() error path (Noralf)
> 	* remove unnecessary clipping from update function (Noralf)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Noralf Trønnes <noralf@tronnes.org>

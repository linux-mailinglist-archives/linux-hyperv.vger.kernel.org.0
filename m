Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6574389AD
	for <lists+linux-hyperv@lfdr.de>; Sun, 24 Oct 2021 17:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhJXPMc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 24 Oct 2021 11:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhJXPMc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 24 Oct 2021 11:12:32 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55973C061745
        for <linux-hyperv@vger.kernel.org>; Sun, 24 Oct 2021 08:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202012; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5txuCn/Ya1wCyoQ6MmVCFYNnO61OkJHTBuUMLqd3+dA=; b=rekqq0WjZqKW+abPNcrSQRFDqB
        9YANC+be+mndTZD4FaLFUn+d2CK6TIAUJ60XsFJOc9PIXJtxCV9mQ3AZB7PDkLq6jrN2DJHIPKkLr
        60VvF+//XOr2Twu3G1oKo2D3QkQjOFKbNmtsw1j6K/DLz9atY/hNi8OD4YgLsXZtK50xdsEWUPPT5
        sQ8lE4nuW009SVfISbGG4sqmWyvJ8TP4oTT2P5+9VSD/QJ43i0QvY0vXgvhmGDVSfFV4BWOP1aFu9
        GlrFRjexVh+PneNk18tB6SC7tHaNgxPAhM1m7IDVAN1NdcppaLA7igg7K1OpCOeMcaq/iHX4Zwysn
        eIpYb12A==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:50038 helo=[192.168.10.61])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1mef8T-000243-8H; Sun, 24 Oct 2021 17:10:09 +0200
Subject: Re: [PATCH 6/9] drm/fb-helper: Allocate shadow buffer of surface
 height
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, drawat.floss@gmail.com,
        airlied@redhat.com, kraxel@redhat.com, david@lechnology.com,
        sam@ravnborg.org, javierm@redhat.com, kernel@amanoeldawod.com,
        dirty.ice.hu@gmail.com, michael+lkml@stapelberg.ch, aros@gmx.com,
        joshua@stroblindustries.com, arnd@arndb.de
Cc:     dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20211022132829.7697-1-tzimmermann@suse.de>
 <20211022132829.7697-7-tzimmermann@suse.de>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <fd218727-24c6-831f-0218-8d21ac22d9d7@tronnes.org>
Date:   Sun, 24 Oct 2021 17:10:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211022132829.7697-7-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



Den 22.10.2021 15.28, skrev Thomas Zimmermann:
> Allocating a shadow buffer of the height of the buffer object does
> not support fbdev overallocation. Use surface height instead.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Noralf Trønnes <noralf@tronnes.org>

Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825B2446A18
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Nov 2021 21:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbhKEUvt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 5 Nov 2021 16:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbhKEUvl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 5 Nov 2021 16:51:41 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1957C061714
        for <linux-hyperv@vger.kernel.org>; Fri,  5 Nov 2021 13:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202012; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ySLsC1EnSHimHBNUlj4wMuCQlyV8d7jeRRm16O5I0YQ=; b=nbyUmWxKe75XmHh/B1M49l+ZYg
        xydu1gbFE1IVOdoZKzlSzVNMrhyuliAV+isL++SJKmBl8FKDNUM0s2TXpNODJzCpTpL9iSboepK/L
        o3rZ4Qu4aDBKukchw8NGmi1eIDpD3B2EuHuAwFV6v9ssLFaG0nHhP5Znp2y1pYotYiH6xBpC/9rXl
        gDbKu4vE8p46AghHSh2Sr+VBHcrbJjfUljZ/omRlQAtYC/xMSlrWiyJ9dCOU7sqXHqKi2qPFQWOeq
        jrYzi+GX8FNcGXn2MPX2yF0q0nSJrQkmjL38649YV0bu1+hHz1IHrkEpxOw8CySv6vD+RQqPYsSyd
        3vEqOCag==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:52208 helo=[192.168.10.61])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1mj68x-0006pi-OU; Fri, 05 Nov 2021 21:48:59 +0100
Subject: Re: [PATCH v2 1/9] drm/format-helper: Export drm_fb_clip_offset()
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, drawat.floss@gmail.com,
        airlied@redhat.com, kraxel@redhat.com, david@lechnology.com,
        sam@ravnborg.org, javierm@redhat.com, kernel@amanoeldawod.com,
        dirty.ice.hu@gmail.com, michael+lkml@stapelberg.ch, aros@gmx.com,
        joshua@stroblindustries.com, arnd@arndb.de
Cc:     dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20211101141532.26655-1-tzimmermann@suse.de>
 <20211101141532.26655-2-tzimmermann@suse.de>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <31701408-4e54-58a4-93c9-c946ef2488af@tronnes.org>
Date:   Fri, 5 Nov 2021 21:48:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211101141532.26655-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



Den 01.11.2021 15.15, skrev Thomas Zimmermann:
> Provide a function that computes the offset into a blit destination
> buffer. This will allow to move destination-buffer clipping into the
> format-helper callers.
> 
> v2:
> 	* provide documentation (Sam)
> 	* return 'unsigned int' (Sam, Noralf)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Noralf Trønnes <noralf@tronnes.org>

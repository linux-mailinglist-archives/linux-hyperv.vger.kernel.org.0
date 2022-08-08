Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BA658CDF2
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Aug 2022 20:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244299AbiHHSpZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Aug 2022 14:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244316AbiHHSpS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Aug 2022 14:45:18 -0400
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com (mailrelay3-1.pub.mailoutpod1-cph3.one.com [46.30.210.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BC8B93
        for <linux-hyperv@vger.kernel.org>; Mon,  8 Aug 2022 11:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=znjEl5VfC+8Kaxye8Js4NPDQxl9vLldFAak2/swvHqo=;
        b=GtQqhoHAZQN5+X66fu82JLWoBx6jsaDo4f6PJOQWpzMMwn0uSiyDxqatFus+UHqprWZc4XQy6bfPk
         aJ6/vEpGo9oRO0A+FM4E1wzKwpuD/B6Cdo//NkGSnMjp0ctS2yJuf/7l7usDfVzTZBKHf7I+JDwwxy
         08D55tBMGKczIpUh/c6rsayjD/gc/lVV3XDq1+FA1GniotyHiiFITWMSzHvjwtqI0i3d4MEcPdpHR1
         U6QeRKxUaB/2VmDanQOwhzFLi2k+xrkr/XPZ9YQ4BBB+qjUau8z4MPclwrxby8ManSEVRpYS4hIIyB
         Gyn4X8iHzWeqiUIs7qSkEGRbEhcXe6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=znjEl5VfC+8Kaxye8Js4NPDQxl9vLldFAak2/swvHqo=;
        b=Lg6i8ut8jnH97SkyD0rutzDuY6+02W2opCKRClkUXVgv9giahUcr4WCo35+sMkDbkIRWD/02IUp5A
         cOMNZRaDQ==
X-HalOne-Cookie: 86a13594f40cf3c3d336840213eb4d6a9dddbf2f
X-HalOne-ID: 3c007d1e-174a-11ed-be82-d0431ea8bb03
Received: from mailproxy3.cst.dirpod3-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 3c007d1e-174a-11ed-be82-d0431ea8bb03;
        Mon, 08 Aug 2022 18:45:12 +0000 (UTC)
Date:   Mon, 8 Aug 2022 20:45:10 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     jose.exposito89@gmail.com, javierm@redhat.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, noralf@tronnes.org,
        drawat.floss@gmail.com, lucas.demarchi@intel.com,
        david@lechnology.com, kraxel@redhat.com,
        linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 04/14] drm/format-helper: Convert drm_fb_swab() to
 struct iosys_map
Message-ID: <YvFZtnKaeOoDSCVD@ravnborg.org>
References: <20220808125406.20752-1-tzimmermann@suse.de>
 <20220808125406.20752-5-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808125406.20752-5-tzimmermann@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Thomas,

On Mon, Aug 08, 2022 at 02:53:56PM +0200, Thomas Zimmermann wrote:
> Convert drm_fb_swab() to use struct iosys_map() and convert users. The
> new interface supports multi-plane color formats, but implementation
> only supports a single plane for now.
> 
> v2:
> 	* use drm_format_info_bpp() (Sam)
> 	* update documentation (Sam)
> 	* add TODO on vaddr location (Sam)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>


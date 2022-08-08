Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F5958CDF5
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Aug 2022 20:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243665AbiHHSsK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Aug 2022 14:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243986AbiHHSsI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Aug 2022 14:48:08 -0400
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com (mailrelay4-1.pub.mailoutpod1-cph3.one.com [46.30.210.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E088B9F
        for <linux-hyperv@vger.kernel.org>; Mon,  8 Aug 2022 11:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=BhhRnrAt9wyuOY21AkpBELEGGKnK2sl/WTGi2e4pR6Y=;
        b=P2rPpRRutX2GxTjySu/NEabaRTyGMieEn/XPhmxRH+gihWaj1c7fYxSWiScgNv0zNsbwV5Mcgw0gD
         uhqLAu1vzJI3N68YCQqlcKbWfHYU+GRIw7W3ILjsglfkGEI5pBVqkOibjFN+AtbaH11TrMUlzU0Iqb
         sLYVsG8wJ01tLH+Dlqfq8IbWIunE7lq/xkRl3ixfBmIgkW+eICUWxNeiqvj75r1x+yrl4SE6EDxAsN
         nEo7v44xo5vyKmGY3JZq48DXP029e6xS+FOHF4+8vcrtnXVbBXLmP2rFMOIg71F9fUQDZgipkiDh4r
         wVueqbzh+S5xI6RS9KN0zWxx8iWUgQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=BhhRnrAt9wyuOY21AkpBELEGGKnK2sl/WTGi2e4pR6Y=;
        b=s9QBiZO6o2FS+3Z8d6BzQSoFZiXrsu1f56QjqReWzKR4p7rbTRqjGpew8WCzJIGEg380mtWM9JGUu
         1L7KLdTCA==
X-HalOne-Cookie: c556d9ec8f471dba3901cbcfc1141056435aafd9
X-HalOne-ID: a32d9dc2-174a-11ed-8244-d0431ea8bb10
Received: from mailproxy2.cst.dirpod3-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id a32d9dc2-174a-11ed-8244-d0431ea8bb10;
        Mon, 08 Aug 2022 18:48:05 +0000 (UTC)
Date:   Mon, 8 Aug 2022 20:48:03 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     jose.exposito89@gmail.com, javierm@redhat.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, noralf@tronnes.org,
        drawat.floss@gmail.com, lucas.demarchi@intel.com,
        david@lechnology.com, kraxel@redhat.com,
        linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 13/14] drm/format-helper: Move destination-buffer
 handling into internal helper
Message-ID: <YvFaY9qRZ+zIPiTS@ravnborg.org>
References: <20220808125406.20752-1-tzimmermann@suse.de>
 <20220808125406.20752-14-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808125406.20752-14-tzimmermann@suse.de>
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

On Mon, Aug 08, 2022 at 02:54:05PM +0200, Thomas Zimmermann wrote:
> The format-convertion helpers handle several cases for different
> values of destination buffer and pitch. Move that code into the
> internal helper drm_fb_xfrm() and avoid quite a bit of duplication.
> 
> v2:
> 	* remove a duplicated blank line (Jose)
> 	* use drm_format_info_bpp() (Sam)
>  	* fix vaddr_cached_hint bug (Sam)
> 	* add TODO on vaddr location (Sam)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

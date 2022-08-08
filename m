Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E6B58CE00
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Aug 2022 20:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiHHSvN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Aug 2022 14:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiHHSvM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Aug 2022 14:51:12 -0400
Received: from mailrelay1-1.pub.mailoutpod1-cph3.one.com (mailrelay1-1.pub.mailoutpod1-cph3.one.com [46.30.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8EE2BDB
        for <linux-hyperv@vger.kernel.org>; Mon,  8 Aug 2022 11:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=s+0IzkHyklav4T4uKNIPC8LopLc1E14ktyVPjmXa5fo=;
        b=ofvJIALLPeLtYlXYuzkfTVRzn/6JQBW2j3y7Y9Osrp3KMGYQpv0E15FDHX4cqeKgDhEaaZm2O6FMn
         W6jYN5Sv9+hHxowCS1/0blyi4P068NEHuTE5uhz5+0AQ4HmB4kJYu2oUNiL2BFtR01CimUpVTWCLsA
         3Yybrj07eXNOLkU4NEh8FxDVBv1Yz9FVEYF3Pz+VdtJlpchq4GiVEM248zuHkZvmkFV8O2WFJHUlaW
         VjiAxkB3nw5yOUM6fnHRgP9lpu5wGeT4QvxiJDzGbPBg6//IyiyJnKcJrvR2ztRjHxoFTgTAHDF2iC
         T2J0pfOXSJ9bRLQ3lyeU1GqCabObZ6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=s+0IzkHyklav4T4uKNIPC8LopLc1E14ktyVPjmXa5fo=;
        b=ZuyWonf+u7HEq4n4GnMb3ltEwU1vl+o1dVh7eBOuIZiawi/GirMN9+hC6O+ncnrnzhli4InIb6RoG
         cyPi23YDg==
X-HalOne-Cookie: a9907ca109aae20e7cc54585a792875938ecdf2c
X-HalOne-ID: 100811f6-174b-11ed-a6cc-d0431ea8a283
Received: from mailproxy3.cst.dirpod4-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 100811f6-174b-11ed-a6cc-d0431ea8a283;
        Mon, 08 Aug 2022 18:51:08 +0000 (UTC)
Date:   Mon, 8 Aug 2022 20:51:06 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     jose.exposito89@gmail.com, javierm@redhat.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, noralf@tronnes.org,
        drawat.floss@gmail.com, lucas.demarchi@intel.com,
        david@lechnology.com, kraxel@redhat.com,
        linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 00/14] drm/format-helper: Move to struct iosys_map
Message-ID: <YvFbGry6dvfTwceK@ravnborg.org>
References: <20220808125406.20752-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808125406.20752-1-tzimmermann@suse.de>
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

On Mon, Aug 08, 2022 at 02:53:52PM +0200, Thomas Zimmermann wrote:
> Change format-conversion helpers to use struct iosys_map for source
> and destination buffers. Update all users. Also prepare interface for
> multi-plane color formats.
> 
> The format-conversion helpers mostly used to convert to I/O memory
> or system memory. To actual memory type depended on the usecase. We
> now have drivers upcomming that do the conversion entirely in system
> memory. It's a good opportunity to stream-line the interface of the
> conversion helpers to use struct iosys_map. Source and destination
> buffers can now be either in system or in I/O memory. Note that the
> implementation still only supports source buffers in system memory.
> 
> This patchset also changes the interface to support multi-plane
> color formats, where the values for each component are stored in
> distinct memory locations. Converting from RGBRGBRGB to RRRGGGBBB
> would require a single source buffer with RGB values and 3 destination
> buffers for the R, G and B values. Conversion-helper interfaces now
> support this.
> 
> v2:
> 	* add IOSYS_MAP_INIT_VADDR_IOMEM (Sam)
> 	* use drm_format_info_bpp() (Sam)
> 	* update documentation (Sam)
> 	* rename 'vmap' to 'src' (Sam)
> 	* many smaller cleanups and fixes (Sam, Jose)
Thanks for the quick respin - I reviewed the remaining patches and looks
good. Nice cleanup of the API and it makes is easier to add more
conversions.

	Sam

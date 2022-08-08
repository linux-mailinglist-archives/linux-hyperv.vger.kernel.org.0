Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E9258CD99
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Aug 2022 20:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243158AbiHHSZf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Aug 2022 14:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236560AbiHHSZe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Aug 2022 14:25:34 -0400
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com (mailrelay3-1.pub.mailoutpod1-cph3.one.com [46.30.210.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECAEB1DD
        for <linux-hyperv@vger.kernel.org>; Mon,  8 Aug 2022 11:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=DL4vMa5P/azkVJcmsKPZQM2DyqZWHnxHJ1IUgaAe5ko=;
        b=MUVC7ymOa0AuSBApiKr0j3nQ+m/+BFEOruI/0L9VoqMW7+ujJ6cA53Pq0rmezvzvELETip/wz2nAu
         7WmYEpa+pDnUjiSWu4vucR1fy1ZIBXLmafAmtYq31irfAOwZEQyhucA2U80OF2hH5MMPvrlhWGFsC0
         lCfl3l4/GFI6tPjXm4OGQMsdbAhkOAMnqQscPYu9Ct0K/Rnpwn/3z6COd4PW09hoe/b/NneuCwNX6r
         6fB4EGWVVd+neMxPC4E4RkfkRxhEJUVMZHNy/HFRpgoOA/J62qHOVMzDRKZxesTUbchNmcwEEBwZSh
         V531G63etkQqedMut6kDggH0gQNRQsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=DL4vMa5P/azkVJcmsKPZQM2DyqZWHnxHJ1IUgaAe5ko=;
        b=UcIIjg6qBlh4dPq7FkO/+PCVMLpeK7shMqjGAr6siExVSpP1A/4BzB2TrSDhlKJ73YAocNt0cKVbY
         g1NXD82AA==
X-HalOne-Cookie: 2a37b78bb632d7de1a520a5208287151bab20f99
X-HalOne-ID: 7a90e9f9-1747-11ed-be82-d0431ea8bb03
Received: from mailproxy2.cst.dirpod3-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 7a90e9f9-1747-11ed-be82-d0431ea8bb03;
        Mon, 08 Aug 2022 18:25:28 +0000 (UTC)
Date:   Mon, 8 Aug 2022 20:25:27 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-hyperv@vger.kernel.org, david@lechnology.com,
        airlied@linux.ie, javierm@redhat.com,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org, drawat.floss@gmail.com,
        noralf@tronnes.org, kraxel@redhat.com, airlied@redhat.com,
        jose.exposito89@gmail.com
Subject: Re: [PATCH 12/12] drm/format-helper: Move destination-buffer
 handling into internal helper
Message-ID: <YvFVF1s5Pk4BmKNU@ravnborg.org>
References: <20220727113312.22407-1-tzimmermann@suse.de>
 <20220727113312.22407-13-tzimmermann@suse.de>
 <Yu1Y8JZCd+wuV2R1@ravnborg.org>
 <f0516ae7-acc2-cf25-b877-74e6637cb78e@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0516ae7-acc2-cf25-b877-74e6637cb78e@suse.de>
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

> > > -	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] = {
> > > -		0, 0, 0, 0
> > > -	};
> > >   	const struct drm_format_info *format = fb->format;
> > > -	u8 cpp = format->cpp[0];
> > >   	void (*swab_line)(void *dbuf, const void *sbuf, unsigned int npixels);
> > > -	switch (cpp) {
> > > +	switch (format->cpp[0]) {
> > >   	case 4:
> > >   		swab_line = drm_fb_swab32_line;
> > >   		break;
> > > @@ -230,21 +249,10 @@ void drm_fb_swab(struct iosys_map *dst, const unsigned int *dst_pitch,
> > >   	default:
> > >   		drm_warn_once(fb->dev, "Format %p4cc has unsupported pixel size.\n",
> > >   			      &format->format);
> > > -		swab_line = NULL;
> > > -		break;
> > > -	}
> > > -	if (!swab_line)
> > >   		return;
> > > +	}
> > > -	if (!dst_pitch)
> > > -		dst_pitch = default_dst_pitch;
> > > -
> > > -	if (dst->is_iomem)
> > > -		drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], cpp,
> > > -				 vmap[0].vaddr, fb, clip, cached, swab_line);
> > > -	else
> > > -		drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], cpp, vmap[0].vaddr, fb,
> > > -			    clip, cached, swab_line);
> > > +	drm_fb_xfrm(dst, dst_pitch, format->cpp, vmap, fb, clip, cached, swab_line);
> > 
> > In this case we pass fb->format-cpp as dst_pitch - so we could retreive
> > is via the fb pointer.
> 
> I don't understand this comment. We're passing format->cpp as dst_pixsize.
> I've meanwhile updated the code to compute the value from
> drm_format_info_bpp().

I wanted to ask if we could drop the format->cpp argument and in
drm_fb_xfrm() use fb->format to retrieve the char per pixel.
So we move this part down in drm_fb_xfrm(), rather than finding
the char per pixel in all callers.

Maybe some of the other callers do not allow this and then this comment
can be ignored.

I have not yet looked at the updated patch-set.

	Sam

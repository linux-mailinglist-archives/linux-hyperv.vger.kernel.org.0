Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E73C58AF61
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Aug 2022 20:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241056AbiHESAb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 5 Aug 2022 14:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241599AbiHESAE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 5 Aug 2022 14:00:04 -0400
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com (mailrelay3-1.pub.mailoutpod1-cph3.one.com [46.30.210.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FAD7AC1C
        for <linux-hyperv@vger.kernel.org>; Fri,  5 Aug 2022 10:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=q/vKBB0XaDXfy/QTySPSqfse9Aar3Bz2vHnneZp8lno=;
        b=u5wvGTKTgDb38fZWgDJTDWkKmMS2tTjTDUpnZayyVEz8vStFY2ELLO6cywmVgyt2vm4bHlpjcThjT
         jJy0Xpe85xfz40wxk/mVnpEC1xfEasf1ZtzVD620ulFV1F6ER7VXGiXBVSyttPMjLUnxRjh8qGa5zC
         Q8uWoiT4VqCm8umbIdMM1teCyR2J4doEaBmdBXMXY5VOp6QDXjqs1GiGt0T7Xij2Yz9I/Epak9dikR
         MMjdL2qiSW6UhH6C2OqAt07H5ElotDCPd1AJpUrBb0BR5EBbs6fjWp2TxMLXYPYYxYlebfl116cktM
         EFtvDl/g3wL/5XGF+qtN+HpkSHMyDRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=q/vKBB0XaDXfy/QTySPSqfse9Aar3Bz2vHnneZp8lno=;
        b=Qk96pzna2LvnC+/Z/UklCBnIV7fLLSrVBKfa3bvhRviqZKb5gIdcHK+rDKz9RqSs8T4Co7Ns74qtD
         OcF265JAQ==
X-HalOne-Cookie: d59c01df2f2e30b20c4cba80847b11ee7a2fe26c
X-HalOne-ID: 5bc96b25-14e8-11ed-be82-d0431ea8bb03
Received: from mailproxy3.cst.dirpod4-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 5bc96b25-14e8-11ed-be82-d0431ea8bb03;
        Fri, 05 Aug 2022 17:59:32 +0000 (UTC)
Date:   Fri, 5 Aug 2022 19:59:31 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     noralf@tronnes.org, daniel@ffwll.ch, airlied@linux.ie,
        mripard@kernel.org, maarten.lankhorst@linux.intel.com,
        airlied@redhat.com, javierm@redhat.com, drawat.floss@gmail.com,
        kraxel@redhat.com, david@lechnology.com, jose.exposito89@gmail.com,
        dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 00/12] drm/format-helper: Move to struct iosys_map
Message-ID: <Yu1ag4cElPDUJ4AM@ravnborg.org>
References: <20220727113312.22407-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727113312.22407-1-tzimmermann@suse.de>
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

On Wed, Jul 27, 2022 at 01:33:00PM +0200, Thomas Zimmermann wrote:
> Change format-conversion helpers to use struct iosys_map for source
> and destination buffers. Update all users. Also prepare interface for
> multi-plane color formats.
> 
> The format-conversion helpers mostly used to convert to I/O memory
> or system memory. To actual memory type depended on the usecase. We
> now have drivers upcomming that do the conversion entirely in system
> memory. It's a good opportunity to stream-line the interface of the
> conversion helpers to use struct iosys_map. Source and destination
> buffers can now be either in system or in I/O memory.

Thanks for looking into this - I like how we hide the memory details in
the helpers (system vs io).

And unifying the system and io variants makes the API simpler - also
good.

> Note that the
> implementation still only supports source buffers in system memory.
Yeah, I noted this in my feedback but realized only now that it is
written here.

I left a few comments (details only) in some of the patches, most are
reviewed without comments.

There is a few general things - mostly bikeshedding about naming and
such. As usual ignore what you think is irrelevant.

	Sam

Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B17158CDF9
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Aug 2022 20:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbiHHStL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Aug 2022 14:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbiHHStK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Aug 2022 14:49:10 -0400
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com (mailrelay3-1.pub.mailoutpod1-cph3.one.com [46.30.210.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E934B9F
        for <linux-hyperv@vger.kernel.org>; Mon,  8 Aug 2022 11:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=nKOYwTZZ65PdC0VRg8e7/XcVp9WooaOm9vxXz1gbBFY=;
        b=TPNGyBac1foa0UsoTE2jesNt3TKqB0NjUSjiOPFkwRSVcuPUXhcTLw2j7GK93EB+AaMsubEdfYmQF
         Q7jbVl/39o+P7VSFclUc6T+NzGmSzepkeGXc5Sp179ml9eQYpSbjnVlot8wjwrYEdDfM4phv4eg4o+
         ebami4unKo1SDCZIUg7RmahVjzrQSYYXWEKgI10Ileh8UmaECUfSvT8dTw+1nBE0hF74gSj3YzN3+m
         9gTXTGCu5dYP4wByI4GmLhmbF6yOJ3B11HBf5sw6EwKiGstRA6GXkOtkm9i/tXfm/+elJGGfuhcE5U
         O7raIrlydTSJvFLiDFiIrVA8Kg9WI4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=nKOYwTZZ65PdC0VRg8e7/XcVp9WooaOm9vxXz1gbBFY=;
        b=MYuJxJSxPDzJ3Xr6Z3WUQ1u/AVjKDX+tGJZADa81fil8E7oUKAEZnSnxRqRBhTjTDmMcIsJwi6SaD
         RtY5qSlBA==
X-HalOne-Cookie: 3967e1364f7fe32ed1414702d454dd7963b225bd
X-HalOne-ID: c7bed67f-174a-11ed-be82-d0431ea8bb03
Received: from mailproxy3.cst.dirpod4-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id c7bed67f-174a-11ed-be82-d0431ea8bb03;
        Mon, 08 Aug 2022 18:49:06 +0000 (UTC)
Date:   Mon, 8 Aug 2022 20:49:05 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     jose.exposito89@gmail.com, javierm@redhat.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, noralf@tronnes.org,
        drawat.floss@gmail.com, lucas.demarchi@intel.com,
        david@lechnology.com, kraxel@redhat.com,
        linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 14/14] drm/format-helper: Rename parameter vmap to src
Message-ID: <YvFaoYvcfC016JRF@ravnborg.org>
References: <20220808125406.20752-1-tzimmermann@suse.de>
 <20220808125406.20752-15-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808125406.20752-15-tzimmermann@suse.de>
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

On Mon, Aug 08, 2022 at 02:54:06PM +0200, Thomas Zimmermann wrote:
> The name the parameter vmap to src in all functions. The parameter
> contains the locations of the source data and the new name says that.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks, this helped in readability!
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

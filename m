Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFA65B4FE1
	for <lists+linux-hyperv@lfdr.de>; Sun, 11 Sep 2022 18:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiIKQLp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 11 Sep 2022 12:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiIKQLo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 11 Sep 2022 12:11:44 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 699762AE3B;
        Sun, 11 Sep 2022 09:11:43 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id D0162204C3EA; Sun, 11 Sep 2022 09:11:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D0162204C3EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1662912702;
        bh=tbufdYlVkrxrgw5goic8vel2LLNei+DjBORn6M2dN/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nAHaIi4vSezJ1hTgheHnhncmVbrJcaVj8tDKgAHysmin9y2CVNTWuyvsHTpShaA1P
         CcCPmmTMaZ5rVYvuHhmAT8x4Lrh9gaiSi+vIvJiUDUtoAKu2Sp4Che2pVn3MiafCNy
         xIKZYj3hhFA8YE9N9a1I48WpY2WusxME/rggy6B8=
Date:   Sun, 11 Sep 2022 09:11:42 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     ssengar@microsoft.com, drawat.floss@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com
Subject: Re: [PATCH] drm/hyperv: Add ratelimit on error message
Message-ID: <20220911161142.GA7754@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1662736193-31379-1-git-send-email-ssengar@linux.microsoft.com>
 <88fab56a-f6e5-bae0-5ed7-1e01c070d136@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88fab56a-f6e5-bae0-5ed7-1e01c070d136@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Sep 10, 2022 at 08:06:05PM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 09.09.22 um 17:09 schrieb Saurabh Sengar:
> >Due to a full ring buffer, the driver may be unable to send updates to
> >the Hyper-V host.  But outputing the error message can make the problem
> >worse because console output is also typically written to the frame
> >buffer.
> >Rate limiting the error message, also output the error code for additional
> >diagnosability.
> >
> >Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> >---
> >  drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> >index 76a182a..013a782 100644
> >--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> >+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> >@@ -208,7 +208,7 @@ static inline int hyperv_sendpacket(struct hv_device *hdev, struct synthvid_msg
> >  			       VM_PKT_DATA_INBAND, 0);
> >  	if (ret)
> >-		drm_err(&hv->dev, "Unable to send packet via vmbus\n");
> >+		drm_err_ratelimited(&hv->dev, "Unable to send packet via vmbus; error %d\n", ret);
> 
> I better option would probably be drm_err_once(). Then you'd get the
> first error message and skip all others.

Thanks for your comment however the intention here is to limit the printk messages and break the chain
rather then printing only once. There can be cases where at different point of time we again get a
ring buffer full condition and we don't want to miss that. We should get the message for each of these
errror which are widely-separated in time not just the first time.

> 
> Best regards
> Thomas
> 
> >  	return ret;
> >  }
> 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> (HRB 36809, AG Nürnberg)
> Geschäftsführer: Ivo Totev




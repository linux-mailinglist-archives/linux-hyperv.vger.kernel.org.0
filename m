Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C12B518737
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 May 2022 16:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbiECOx5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 3 May 2022 10:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237450AbiECOxt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 3 May 2022 10:53:49 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E4F82643;
        Tue,  3 May 2022 07:50:17 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id B010220EB0C2; Tue,  3 May 2022 07:50:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B010220EB0C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1651589416;
        bh=0Hrt9d53XFYn9YSRDobyKkPMyz3dSW6P495Q/i0i1Ps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kh3Rj//hhW+2Kh5YVIiJjwhYzkhhH9wtCU83cMWz9hDFOjbMNhnwDYsK/zWyjCpG9
         dpze87O/ppLvHW2o4T+Kvkuwz0GY/rQPnF59tpiEwDf2OxmMdm1JTHtH3sNCRrOYgH
         ucDAp4wSxdiocvG4ZmLgMJ0RwWQANoGmnu26dVk4=
Date:   Tue, 3 May 2022 07:50:16 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        "drawat.floss@gmail.com" <drawat.floss@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: Re: [PATCH v4] drm/hyperv: Add error message for fb size greater
 than allocated
Message-ID: <20220503145016.GA25079@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1649737739-10113-1-git-send-email-ssengar@linux.microsoft.com>
 <BYAPR21MB127064CAEA28FBBFB34672C3BFED9@BYAPR21MB1270.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB127064CAEA28FBBFB34672C3BFED9@BYAPR21MB1270.namprd21.prod.outlook.com>
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

On Tue, Apr 12, 2022 at 05:06:07AM +0000, Dexuan Cui wrote:
> > From: Saurabh Sengar <ssengar@linux.microsoft.com>
> > Sent: Monday, April 11, 2022 9:29 PM
> >  ...
> > Add error message when the size of requested framebuffer is more than
> > the allocated size by vmbus mmio region for framebuffer
> 
> The line lacks a period, but I guess the maintainer may help fix it for you :-)
>  
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> 
> Reviewed-by: Dexuan Cui <decui@microsoft.com>

Can this be queued for next ? please let me know in case any clarification required.

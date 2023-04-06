Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F2E6D8DD5
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Apr 2023 05:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbjDFDDV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Apr 2023 23:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbjDFDDT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Apr 2023 23:03:19 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D533A9000;
        Wed,  5 Apr 2023 20:03:16 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 51E09210DEF9; Wed,  5 Apr 2023 20:03:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 51E09210DEF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680750196;
        bh=MdrDqA6Qeb/ILxHhwP7+1Uzg6nZ+rSwgqf6Gqiot8d8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aYckd0w3iqJb83XwX+wOCKW2XKE8rf4b+K4QgQHVCVafw2IQyILq9Q/lrAAnEJKBH
         UVXNiSs7jL0Ty+AH5BuQUL/i6pORFmgG+YIL+52BeE4Vl7/KkaFSIHSyzOrhquGPzn
         chKlm0J+v745InY8fm854292OGtm0WtU3ESzWF3U=
Date:   Wed, 5 Apr 2023 20:03:16 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        mikelley@microsoft.com
Subject: Re: [PATCH v9 4/5] dt-bindings: bus: VMBus
Message-ID: <20230406030316.GA9750@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1679298460-11855-1-git-send-email-ssengar@linux.microsoft.com>
 <1679298460-11855-5-git-send-email-ssengar@linux.microsoft.com>
 <ZC3/2Xf+L3rer9ds@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC3/2Xf+L3rer9ds@liuwe-devbox-debian-v2>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 05, 2023 at 11:10:17PM +0000, Wei Liu wrote:
> On Mon, Mar 20, 2023 at 12:47:39AM -0700, Saurabh Sengar wrote:
> > Add dt-bindings for Hyper-V VMBus.
> 
> Do you perhaps want to use this as the commit subject line? The original
> one looks to be cut off half way.

In the first version of this patch series, I had this as subject line, however
'dt-bindings' was repetetive in subject line hence asked to be dropped by
device-tree maintainers.

Ref: https://lore.kernel.org/lkml/f74fe561-dc20-0681-12af-4a4782a060be@linaro.org/

If this subject line looks cut in half, may be we can modify it to:
dt-bindings: bus: Add Hyper-V VMBus

Regards,
Saurabh

> 
> I can change this patch on my end. Just let me know.
> 
> Thanks,
> Wei.

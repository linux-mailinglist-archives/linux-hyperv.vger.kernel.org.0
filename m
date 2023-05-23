Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D780070D337
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 May 2023 07:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjEWFgc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 23 May 2023 01:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEWFgb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 May 2023 01:36:31 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29EA5109;
        Mon, 22 May 2023 22:36:28 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1134)
        id 6DAC320FB999; Mon, 22 May 2023 22:36:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6DAC320FB999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1684820187;
        bh=DJlGDQvSIvFeKq1xoknA5bnOBGdDqtcUpdxg6zY8oeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LGuQJ00Sro2QYqmdwLp1OTQZV1PYu4sHGKN62sbRAG4uaougSP/gPN09pf8ERbae8
         kXFkW58SKHAxHy+Rzw7zGlLuwY3gGlY8Tvb1Ta7h3KpkH9pQIwD/cLFpqFrDfDcZJ9
         d/8/BKS/1nJWEdgSr9Ze+HBgQl+/eslKVuVVDjb0=
Date:   Mon, 22 May 2023 22:36:27 -0700
From:   Shradha Gupta <shradhagupta@linux.microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>, Ani Sinha <anisinha@redhat.com>
Cc:     Olaf Hering <olaf@aepfle.de>, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v3] hv/hv_kvp_daemon: Add support for keyfile config
 based connection profile in NM
Message-ID: <20230523053627.GA10913@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1683265875-3706-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20230508095340.2ca1630f.olaf@aepfle.de>
 <ZFknuu+f74e1zHZe@liuwe-devbox-debian-v2>
 <20230508191246.2fcd6eb5.olaf@aepfle.de>
 <ZFkuY4dmwiPsUJ3+@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFkuY4dmwiPsUJ3+@liuwe-devbox-debian-v2>
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

On Mon, May 08, 2023 at 05:16:19PM +0000, Wei Liu wrote:
> On Mon, May 08, 2023 at 07:12:46PM +0200, Olaf Hering wrote:
> > Mon, 8 May 2023 16:47:54 +0000 Wei Liu <wei.liu@kernel.org>:
> > 
> > > Olaf, is this a reviewed-by from you? :-)
> > 
> > Sorry, I did not review the new functionality, just tried to make sure there will be no regression for existing consumers.
> 
> Okay, this is fine, too. Thank you for looking into this.
> 
> 
> > 
> > Olaf
> 

Gentle reminder.

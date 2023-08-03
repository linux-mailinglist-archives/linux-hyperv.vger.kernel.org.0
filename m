Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094F176F085
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Aug 2023 19:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjHCRXS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Aug 2023 13:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjHCRXR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Aug 2023 13:23:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E91530C0;
        Thu,  3 Aug 2023 10:23:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15E6361E57;
        Thu,  3 Aug 2023 17:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5C7C433C8;
        Thu,  3 Aug 2023 17:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691083395;
        bh=y8eGtQQgDapSBxqm5rIyj31sufYbaMEgXLeK19zO7LI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TV3mGJLBxAKOBcjGquYn6Gmjq5TTuB4Rk54K0nNdkJ1siAAM/5vGB2E+7iMCzVCme
         n9nXIb/CClmNhi6ktroMwe4JvPmRFSFr27xkNFHdKsm2ZZUuHjLBm4XWoOwahOUcW4
         4sj8DuAAoqVO2oD9Q6uB18ShOzdXg2sjN9k7UjJgR6S0nGPqp2WXSWSqLmh4nBLb0M
         DbXUCm220kMgBYoWGauX8beHsnG80zR6F+j0jEzqZHIUOwOnx8oZyB8nUXt+CnVTmd
         sNcVnhoCz0DaVqMXqo1MeCZJlsjpURrhifAEm+/idcGd+m1n+CB+0+lxETSXaGb8bW
         vfQtqWR4pGQLA==
Date:   Thu, 3 Aug 2023 10:23:14 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Simon Horman <horms@kernel.org>
Cc:     Sonia Sharma <sosha@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, sosha@microsoft.com, kys@microsoft.com,
        mikelley@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, longli@microsoft.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH v3 net] net: hv_netvsc: fix netvsc_send_completion to
 avoid multiple message length checks
Message-ID: <20230803102314.768b6462@kernel.org>
In-Reply-To: <ZMuaCetqzgRsMDvd@kernel.org>
References: <1691023528-5270-1-git-send-email-sosha@linux.microsoft.com>
        <ZMuaCetqzgRsMDvd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 3 Aug 2023 14:14:01 +0200 Simon Horman wrote:
> > The switch statement in netvsc_send_completion() is incorrectly validating
> > the length of incoming network packets by falling through to the next case.
> > Avoid the fallthrough. Instead break after a case match and then process
> > the complete() call.
> > 
> > Signed-off-by: Sonia Sharma <sonia.sharma@linux.microsoft.com>  
> 
> Hi Sonia,
> 
> if this is a bug-fix, which seems to be the case, then it probably warrants
> a Fixes tag.

And a description of what this problem results in. The commit message
kinda tells us what the patch does, which we already see from the code.
Paraphrasing corporate America "focus on the impact"...
-- 
pw-bot: cr

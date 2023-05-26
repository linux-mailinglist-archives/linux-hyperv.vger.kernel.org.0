Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E2F711E6B
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 May 2023 05:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjEZD0C (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 25 May 2023 23:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjEZD0A (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 25 May 2023 23:26:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498EDE6;
        Thu, 25 May 2023 20:26:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D846B6471F;
        Fri, 26 May 2023 03:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F170C433EF;
        Fri, 26 May 2023 03:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685071559;
        bh=BTIaAcxw6JMw/kBG+7/ytX8/qt2HopHJ9Nqlbp6SrPU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eIztQ0pfSz7V7fBvUzeog84FT45VkAZ2Lae27wsJjMo2fG1neQr92ibbIFgGHsQ2d
         r4JJTPcmgjMJnT+uzL6zfSlfkfBY8dFo++z67mnF7wrr/9P/KiWD0ShmXwko8V+SIE
         zoqSY3IREiAbPn2Znwq2kn2tRNNV2Ly7FViIEibdDkP7RxB1FMhHu22yVTGyQYbsN2
         OX4koaThdA9hIKe7/x64Ho3jdyINstDb+ujciIDpcmybpuL5c2X9JGIqtJNRCxc5Ni
         jKHY5EnBMTUPsHPsGt8BBA+PoBgarYho9GcKQlrbQUIpEZqkQSQWDIuFJen+j5HryZ
         CMMU/YZeGrRJQ==
Date:   Thu, 25 May 2023 20:25:57 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        decui@microsoft.com, kys@microsoft.com, paulros@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net,
        wei.liu@kernel.org, edumazet@google.com, pabeni@redhat.com,
        leon@kernel.org, longli@microsoft.com, ssengar@linux.microsoft.com,
        linux-rdma@vger.kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
        sharmaajay@microsoft.com, hawk@kernel.org, tglx@linutronix.de,
        shradhagupta@linux.microsoft.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH V2,net] net: mana: Fix perf regression: remove rx_cqes,
 tx_cqes counters
Message-ID: <20230525202557.5a5f020b@kernel.org>
In-Reply-To: <1685025990-14598-1-git-send-email-haiyangz@microsoft.com>
References: <1685025990-14598-1-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 25 May 2023 07:46:30 -0700 Haiyang Zhang wrote:
> lot caching and memory overhead, hence perf regression.

Horatiu's ask for more details was perfectly reasonable.
Provide more details to give the distros and users an
idea of the order of magnitude of the problem. Example
workload and relative perf hit, anything.

Please do not repost within 24 hours:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
-- 
pw-bot: cr

Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2807B610299
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Oct 2022 22:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236745AbiJ0UWL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Oct 2022 16:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236888AbiJ0UWK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Oct 2022 16:22:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE5B6F27E;
        Thu, 27 Oct 2022 13:22:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DF96624E5;
        Thu, 27 Oct 2022 20:22:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18707C433D6;
        Thu, 27 Oct 2022 20:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666902128;
        bh=3qACGMX98yNt/3+nPW3vdpznrRqLQ2kS8CcfASjlmbg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hbkKtTIysV9PMJ78KqpXKvMrnvmJ01ezXuXhmojF+U0SBu7ob4dsv3K0fuS7k+xDh
         FXZ6CV2dWY7Hxyg1T2+rzUTbApbnK+04khXHcCbybviTCBfC61gIFoFdOzj60d2NhP
         Bw/1aOHhb9wzi0eNJ8bbg1rZK2snI43tc3z5UFKk=
Date:   Thu, 27 Oct 2022 13:22:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Shradha Gupta <shradhagupta@linux.microsoft.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v2 1/2] mm/page_reporting: Add checks for
 page_reporting_order param
Message-Id: <20221027132207.bb4e9408e1ca94b3dfaca405@linux-foundation.org>
In-Reply-To: <Y1lTWxMnk3lnS+3V@liuwe-devbox-debian-v2>
References: <1664447081-14744-1-git-send-email-shradhagupta@linux.microsoft.com>
        <1664517699-1085-1-git-send-email-shradhagupta@linux.microsoft.com>
        <1664517699-1085-2-git-send-email-shradhagupta@linux.microsoft.com>
        <Y1lTWxMnk3lnS+3V@liuwe-devbox-debian-v2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, 26 Oct 2022 15:33:47 +0000 Wei Liu <wei.liu@kernel.org> wrote:

> On Thu, Sep 29, 2022 at 11:01:38PM -0700, Shradha Gupta wrote:
> > Current code allows the page_reporting_order parameter to be changed
> > via sysfs to any integer value.  The new value is used immediately
> > in page reporting code with no validation, which could cause incorrect
> > behavior.  Fix this by adding validation of the new value.
> > Export this parameter for use in the driver that is calling the
> > page_reporting_register().
> > This is needed by drivers like hv_balloon to know the order of the
> > pages reported. Traditionally the values provided in the kernel boot
> > line or subsequently changed via sysfs take priority therefore, if
> > page_reporting_order parameter's value is set, it takes precedence
> > over the value passed while registering with the driver.
> > 
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> 
> Andrew and other MM reviewers, can I get an ack / nack for this patch?

Looks OK to me.  Can this be merged via the hyperv tree?

Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751AB551F11
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jun 2022 16:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbiFTOjM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 20 Jun 2022 10:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348414AbiFTOil (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 20 Jun 2022 10:38:41 -0400
Received: from mail.sysgo.com (mail.sysgo.com [159.69.174.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3E42642;
        Mon, 20 Jun 2022 06:55:45 -0700 (PDT)
Date:   Mon, 20 Jun 2022 15:55:42 +0200
From:   Vit Kabele <vit.kabele@sysgo.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        kys@microsoft.com
Subject: Re: [RFC PATCH] Hyper-V: Initialize crash reporting before vmbus
Message-ID: <YrB8Xvjp2KKQ/JhT@czspare1-lap.sysgo.cz>
Mail-Followup-To: Vit Kabele <vit.kabele@sysgo.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org, kys@microsoft.com
References: <YqtAyitIGRAHL7V0@czspare1-lap.sysgo.cz>
 <874k0kirbf.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874k0kirbf.fsf@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jun 16, 2022 at 05:03:16PM +0200, Vitaly Kuznetsov wrote:
> Vit Kabele <vit.kabele@sysgo.com> writes:
> > Nevertheless, I am not sure about following:
> >
> > 1/ The vmbus_initiate_unload function is called within the panic handler
> > even when the vmbus initialization does not finish (there might be no
> > vmbus at all). This should probably not be problem because the vmbus
> > unload function always checks for current connection state and does
> > nothing when this is "DISCONNECTED". For better readability, it might be
> > better to add separate panic notifier for vmbus and crash reporting.
> >
> > 2/ Wouldn't it be better to extract the whole reporting capability out
> > of the vmbus module, so that it stays present in the kernel even when
> > the vmbus module is possibly unloaded?
> 
> IMHO yes but as you mention hyperv_panic_event() currently does to
> things:
> 1) Initiates VMBus unload
> 2) Reports panic to the hypervisor
> 
> I think untangling them moving the later to arch/x86/hyper-v (and
> arch/arm64/hyperv/) makes sense.
Ok, I will send the complete patch soon.

-- 
Best regards,
Vit Kabele

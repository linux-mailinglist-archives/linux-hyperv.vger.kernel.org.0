Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D264CB441
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Mar 2022 02:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiCCBKJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Mar 2022 20:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiCCBKH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Mar 2022 20:10:07 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBA332D1F5;
        Wed,  2 Mar 2022 17:09:22 -0800 (PST)
Received: from [192.168.1.17] (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7389920B7178;
        Wed,  2 Mar 2022 17:09:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7389920B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646269762;
        bh=0A9U3/A1+sfRyujc9HpaWZgG2Yh/DJChDIAh5jtJwK8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DizS9EAjkuOlxzJb2WrrLVIGurQ+MgGe6Hq5pB62M48Xc3JusNC/qzQfHkD5sm65U
         355H29NJ7MUufUpRbdXJLkFG/kTdd9QT1OthG6rNaz3o0CXqK+VQMqrhSdX/rwtfos
         JjqKGFqvZxt0RJam1K4Mu+IR49pL12o2XWiznzT8=
Message-ID: <c848ade1-48e4-1868-b890-9c3401cff9de@linux.microsoft.com>
Date:   Wed, 2 Mar 2022 17:09:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 02/30] drivers: hv: dxgkrnl: Driver initialization and
 loading
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>, Wei Liu <wei.liu@kernel.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        spronovo@microsoft.com, spronovo@linux.microsoft.com
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <739cf89e71ff72436d7ca3f846881dfb45d07a6a.1646163378.git.iourit@linux.microsoft.com>
 <Yh6F9cG6/SV6Fq8Q@kroah.com>
 <20220301222321.yradz24nuyhzh7om@liuwe-devbox-debian-v2>
 <Yh8ia7nJNN7ISR1l@kroah.com>
From:   Iouri Tarassov <iourit@linux.microsoft.com>
In-Reply-To: <Yh8ia7nJNN7ISR1l@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 3/1/2022 11:53 PM, Greg KH wrote:
> On Tue, Mar 01, 2022 at 10:23:21PM +0000, Wei Liu wrote:
> > > > +struct dxgglobal *dxgglobal;
> > > 
> > > No, make this per-device, NEVER have a single device for your driver.
> > > The Linux driver model makes it harder to do it this way than to do it
> > > correctly.  Do it correctly please and have no global structures like
> > > this.
> > > 
> > 
> > This may not be as big an issue as you thought. The device discovery is
> > still done via the normal VMBus probing routine. For all intents and
> > purposes the dxgglobal structure can be broken down into per device
> > fields and a global structure which contains the protocol versioning
> > information -- my understanding is there will always be a global
> > structure to hold information related to the backend, regardless of how
> > many devices there are.
>
> Then that is wrong and needs to be fixed.  Drivers should almost never
> have any global data, that is not how Linux drivers work.  What happens
> when you get a second device in your system for this?  Major rework
> would have to happen and the code will break.  Handle that all now as it
> takes less work to make this per-device than it does to have a global
> variable.
>
> > I definitely think splitting is doable, but I also understand why Iouri
> > does not want to do it _now_ given there is no such a model for multiple
> > devices yet, so anything we put into the per-device structure could be
> > incomplete and it requires further changing when such a model arrives
> > later.
> > 
> > Iouri, please correct me if I have the wrong mental model here.
> > 
> > All in all, I hope this is not going to be a deal breaker for the
> > acceptance of this driver.
>
> For my reviews, yes it will be.
>
> Again, it should be easier to keep things in a per-device state than
> not as the proper lifetime rules and the like are automatically handled
> for you.  If you have global data, you have to manage that all on your
> own and it is _MUCH_ harder to review that you got it correct.

Hi Greg,

I do not really see how the driver be written without the global data. Let's review the design.

Dxgkrnl acts as the aggregator of all virtual compute devices, projected by the host. It needs to do operations, which do not belong to a particular compute device. For example, cross device synchronization and resource sharing.

A PCI device device is created for each virtual compute device. Therefore, there should be a global list of objects and a mutex to synchronize access to the list.

A VMBus channel is offered by the host for each compute device. The list of the VMBus channels should be global.

A global VMBus channel is offered by the host. The channel does not belong to any particular compute device, so it must be global.

IO space is shared by all compute devices, so its parameters should be global.

Dxgkrnl needs to maintain a list of processes, which opened compute device objects. Dxgkrnl maintains private state for each process and when a process opens the /dev/dxg device, Dxgkrnl needs to find if the process state is already created by walking the global process list.

Now, where to keep this global state? It could be kept in the /dev/dxg private device structure. But this structure is not available when, for example, dxg_pci_probe_device() or dxg_probe_vmbus() is called.

Can there be multiple /dev/dxg devices? No. Because the /dev/dxg device represents the driver itself, not a particular compute device.

I am not sure what design model you have in mind when saying there should be no global data. Could you please explain keeping in mind the above requirements?

Thanks
Iouri


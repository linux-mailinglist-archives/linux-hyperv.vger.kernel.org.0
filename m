Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1233B6A1A92
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Feb 2023 11:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjBXKua convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-hyperv@lfdr.de>); Fri, 24 Feb 2023 05:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjBXKu3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 24 Feb 2023 05:50:29 -0500
X-Greylist: delayed 1934 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Feb 2023 02:50:27 PST
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D761D15885;
        Fri, 24 Feb 2023 02:50:27 -0800 (PST)
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     Sean Christopherson <seanjc@google.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clockevents/drivers/i8253: Do not zero timer counter in
 shutdown
Thread-Topic: [PATCH] clockevents/drivers/i8253: Do not zero timer counter in
 shutdown
Thread-Index: AQHZOpLxLW8Whz5HbUGqx7zeXRG6Ia7EObywgABoMQCAGU3w8A==
Date:   Fri, 24 Feb 2023 09:45:39 +0000
Message-ID: <12889cfa141f4a06958ead0ab7f0a375@baidu.com>
References: <1675732476-14401-1-git-send-email-lirongqing@baidu.com>
 <BYAPR21MB168840B3814336ED510845C0D7D89@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y+O56OXIuARBhsg2@google.com>
In-Reply-To: <Y+O56OXIuARBhsg2@google.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.206.13]
x-baidu-bdmsfe-datecheck: 1_BJHW-Mail-Ex14_2023-02-24 17:45:40:275
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-FEAS-Client-IP: 10.127.64.37
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 15:10:21:SYSTEM
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > > Hyper-V and KVM follow the spec, the issue that 35b69a42
> > > "(clockevents/drivers/
> > > i8253: Add support for PIT shutdown quirk") fixed is in i8253
> > > drivers, not Hyper-v, so delete the zero timer counter register in
> > > shutdown, and delete PIT shutdown quirk for Hyper-v
> >
> > From the standpoint of Hyper-V, I'm good with this change.  But
> > there's a risk that old hardware might not be compliant with the spec,
> > and needs the zero'ing for some reason. The experts in the x86 space
> > will be in the best position to assess the risk.
> 
> Yep, my feeling exactly.  My input is purely from reading those crusty old specs.

Hi Thomas:

Could you give some suggestion about this patch?

Thanks

-Li

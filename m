Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7740E6E1BCA
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Apr 2023 07:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjDNFgj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Apr 2023 01:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDNFgi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Apr 2023 01:36:38 -0400
X-Greylist: delayed 145930 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Apr 2023 22:36:36 PDT
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0262B35A1;
        Thu, 13 Apr 2023 22:36:35 -0700 (PDT)
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     Wei Liu <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     Sean Christopherson <seanjc@google.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
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
Thread-Index: AQHZOpLxLW8Whz5HbUGqx7zeXRG6Ia7EObywgABoMQCAY1X+0IAAW1iAgAJXbhA=
Date:   Fri, 14 Apr 2023 05:17:01 +0000
Message-ID: <f6e1bb3243354dd9bc78522f8c119e43@baidu.com>
References: <1675732476-14401-1-git-send-email-lirongqing@baidu.com>
 <BYAPR21MB168840B3814336ED510845C0D7D89@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y+O56OXIuARBhsg2@google.com> <3b8496c071214bda9e5ecfa048f18ab9@baidu.com>
 <1311175816673.202304.ZDdawTGHoa/UH20U@liuwe-devbox-debian-v2>
In-Reply-To: <1311175816673.202304.ZDdawTGHoa/UH20U@liuwe-devbox-debian-v2>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.204.50]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.56
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 15:10:21:SYSTEM
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiA+DQo+ID4NCj4gPiBQaW5nDQo+IA0KPiBJIGd1ZXNzIHlvdSB3YW50IFRob21hcyBHbGVpeG5l
ciBhbmQgRGFuaWVsIExlemNhbm8ncyBhdHRlbnRpb24uDQo+IA0KDQpZZXMsIA0KDQpUaGFua3Mg
eW91DQoNCi1MaQ0KDQo=

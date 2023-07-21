Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F1675C902
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jul 2023 16:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjGUOHZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-hyperv@lfdr.de>); Fri, 21 Jul 2023 10:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjGUOHX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Jul 2023 10:07:23 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B5D2D47
        for <linux-hyperv@vger.kernel.org>; Fri, 21 Jul 2023 07:07:21 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-40-CznJ0uSZOPChlYzhGu5ogQ-1; Fri, 21 Jul 2023 15:07:19 +0100
X-MC-Unique: CznJ0uSZOPChlYzhGu5ogQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 21 Jul
 2023 15:07:17 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 21 Jul 2023 15:07:17 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Michael Kelley (LINUX)'" <mikelley@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/1] x86/hyperv: Disable IBT when hypercall page lacks
 ENDBR instruction
Thread-Topic: [PATCH 1/1] x86/hyperv: Disable IBT when hypercall page lacks
 ENDBR instruction
Thread-Index: AQHZu0mXUyEtW9eyqkWnVGF605KOSq/DKCeAgAAzncCAAOUgwIAAAcAw
Date:   Fri, 21 Jul 2023 14:07:17 +0000
Message-ID: <533c3cae084f4c2aaf7227e113029d9f@AcuMS.aculab.com>
References: <1689885237-32662-1-git-send-email-mikelley@microsoft.com>
 <20230720211553.GA3615208@hirez.programming.kicks-ass.net>
 <SN6PR2101MB16933FAC4E09E15D824EB2FDD73FA@SN6PR2101MB1693.namprd21.prod.outlook.com>
 <BYAPR21MB16889A4BD21DA1F8357008FFD73FA@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB16889A4BD21DA1F8357008FFD73FA@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b52301eb-604c-44e1-bf56-29beb984d9b4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-21T00:20:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

...
> I realized in the middle of the night that my reply was nonsense. :-(
> pr_warn() makes the message visible when pr_info() might not.  I'm
> happy to change to pr_warn().

PANIC_ON_WARN??

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


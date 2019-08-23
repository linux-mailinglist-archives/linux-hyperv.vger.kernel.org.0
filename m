Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCCD9B4C0
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2019 18:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404159AbfHWQoN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 23 Aug 2019 12:44:13 -0400
Received: from mail-eopbgr740117.outbound.protection.outlook.com ([40.107.74.117]:43829
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731416AbfHWQoN (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 23 Aug 2019 12:44:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHBNThrquE49fwcv4SjoNDhM30PNXDDNE/FQebnY5YFWW7M36boW+y239ldni7ElDkMrUXPneKtk4tuU2EC1zAVLDlpxSp/K4qxftyXlfc70mFQVSdTPUO5vhav458GFTbiM247efmp/BowiJWFfKEYIZq4YSgeFq56CojyKsACAyHFKyy7z4mUZey+s+C5cYMFN3tBErqyopzv6z1cROcDGqFmqHJun8NACFDPL692PPxbKckb9w1+ELlBcW6K36P+T4RgmuciJM3w1z5ULBscjRNyTstnMZ1AAAC5mEUrLT6zKziiMT61mZyxmeM6Pq7RswDJaQZcZ2SfrJr5eaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oofX5g7863DrsuTBLgwz9lRxcVlcj8ZJjSJyqLzOp8=;
 b=X2eakgPvP/NZ4EQ+XS3ZKvWztq0h42NV5B5ip8NqJLjPUJiPJizDPtF699kr9Dj/LzSPf0g77Gz4zGDFuFXLcU5jqhyqVWJA9aRyyaPAv4jZeGJmSN55M3jsY5mS0BGDn7WkfmC0RRHRO4ZNiNuiglefMIfvvRDHvWSEhtDfIPHuo9F62QgTS/WkJFqLNE0BH3zpZW0t44FE4sK0pXiAatyykksPU90QJYvm4InsguTFnWTzQDh4rHQb362Nx6B5Kj1jP/PWQoBtgR2/nXy7oy9jbq17ZsNAHV+YliSIk1W+tcL47oNG3+Jecs4lFwIRrdDR+FxGtAdWRmb7+HDcIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oofX5g7863DrsuTBLgwz9lRxcVlcj8ZJjSJyqLzOp8=;
 b=TCSwu6T1V6TI8ky88WBVlUJlXkN6UqnWIMzJ3cGztQxbiSve7iGSvkLqdf7M1SgRRmeb7wHeQiDaB+cVMEOXhI+UN/718ygszMHpqvgRCX9I1MFTe4z/Lt205t6qOaninoCKdZWzd+EAlXXCvx5xtvj8DJs80Kk1GmyycLwJrdQ=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0153.namprd21.prod.outlook.com (10.173.173.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.4; Fri, 23 Aug 2019 16:44:09 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::8985:a319:f21:530e]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a%8]) with mapi id 15.20.2220.000; Fri, 23 Aug 2019
 16:44:09 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     brandonbonaby94 <brandonbonaby94@gmail.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] drivers: hv: vmbus: Introduce latency testing
Thread-Topic: [PATCH v2 1/3] drivers: hv: vmbus: Introduce latency testing
Thread-Index: AQHVVwE2vVCk3RDz8U68oyYvQlF7g6cGJmDQgAH0KwCAANXUYA==
Date:   Fri, 23 Aug 2019 16:44:09 +0000
Message-ID: <DM5PR21MB01379300AF2B441D0B53692DD7A40@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <cover.1566266609.git.brandonbonaby94@gmail.com>
 <ebca54bf70d2af53de419c1b7ac8db5b77b888cb.1566266609.git.brandonbonaby94@gmail.com>
 <DM5PR21MB01375C24AE9ECD93DBE856C2D7AA0@DM5PR21MB0137.namprd21.prod.outlook.com>
 <20190823033850.GA41496@Test-Virtual-Machine>
In-Reply-To: <20190823033850.GA41496@Test-Virtual-Machine>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-23T16:44:06.9386039Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2c489af9-19e6-41b4-a757-33b066953da7;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 786e7d22-ddb3-4374-5aaf-08d727e91ec2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR21MB0153;
x-ms-traffictypediagnostic: DM5PR21MB0153:|DM5PR21MB0153:|DM5PR21MB0153:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR21MB015318491632D9A3F25F9608D7A40@DM5PR21MB0153.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(199004)(189003)(186003)(55016002)(10090500001)(66066001)(71200400001)(5660300002)(52536014)(26005)(6436002)(229853002)(10290500003)(71190400001)(446003)(11346002)(54906003)(76116006)(66946007)(4326008)(305945005)(476003)(86362001)(66556008)(66476007)(76176011)(2906002)(66446008)(53936002)(64756008)(256004)(99286004)(6246003)(7696005)(74316002)(14454004)(316002)(33656002)(102836004)(8990500004)(22452003)(25786009)(1411001)(9686003)(6506007)(8936002)(3846002)(6916009)(478600001)(6116002)(7736002)(81156014)(8676002)(486006)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0153;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DxPpAAfIr6c4xyebDGutv/EzyAbltVQa+AREqWLqK3w8xhTcSbYR0Y2YkCu30/UH/vzuSAWeYGX2oybdZxBuRFWjKwgy2/Bw6gq9exoGGEJ7hQCyFKNM5osbHPMzIg/Fql3nO7Sgygq5hwYkBw9R5m9IzHOC5vA7rn0XxQCNPRJIeOnd7VgnhbLaLNRxlpZNrRTEnpaUfMZI2WWwyZptIOHlOh52QDaQid1xyK+5kv5EWBQofbR5Rwz6C7yToj8DxdqsuFcv+qq5aixDHj5PbK9kGn0bPd9snb6WvAHHpmKXV9A1G2J8CBTL+tN2oqC78zYxWTiUnp2UFoUJy3RUwFxS9FS8j5BM0Q1m9rAUh1+GtGnk+PdtG3+JkAI6ZYuABm0EH9cBoIwxK6TDyX+Fx1/H4VRZkoCVKrGWgS7fjiY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786e7d22-ddb3-4374-5aaf-08d727e91ec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 16:44:09.1192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QOlA90rF4RqA+kuZpLGQ7e0VDXRzM4daKnUqFkhXXWKr01L2yfsXn7HxAuYfJJtBdgtEJ11ZruIyqiuIi1fGo2zRz+rMFE8zo7DMclCHRyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0153
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Branden Bonaby <brandonbonaby94@gmail.com> Sent: Thursday, August 22,=
 2019 8:39 PM
> > > diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> > > index 09829e15d4a0..c9c63a4033cd 100644
> > > --- a/drivers/hv/connection.c
> > > +++ b/drivers/hv/connection.c
> > > @@ -357,6 +357,9 @@ void vmbus_on_event(unsigned long data)
> > >
> > >  	trace_vmbus_on_event(channel);
> > >
> > > +#ifdef CONFIG_HYPERV_TESTING
> > > +	hv_debug_delay_test(channel, INTERRUPT_DELAY);
> > > +#endif /* CONFIG_HYPERV_TESTING */
> >
> > You are following Vitaly's suggestion to use #ifdef's so no code is
> > generated when HYPERV_TESTING is not enabled.  However, this
> > direct approach to using #ifdef's really clutters the code and makes
> > it harder to read and follow.  The better approach is to use the
> > #ifdef in the include file where the functions are defined.  If
> > HYPERV_TESTING is not enabled, provide a #else that defines
> > the function with an empty implementation for which the compiler
> > will generate no code.   An as example, see the function definition
> > for hyperv_init() in arch/x86/include/asm/mshyperv.h.  There are
> > several functions treated similarly in that include file.
> >
>=20
> I checked out the code in arch/x86/include/asm/mshyperv.h, after
> thinking about it, I'm wondering if it would be better just to have
> two files one called hv_debugfs.c and the other hyperv_debugfs.h.
> I could put the code definitions in hv_debugfs.c and at the top
> include the hyperv_debugfs.h file which would house the declarations
> of these functions under the ifdef. Then like you alluded too use
> an #else statement that would have the null implementations of the
> above functions. Then put an #include "hyperv_debugfs.h" in the
> hyperv_vmbus.h file. I figured instead of putting the code directly
> into the vmbus_drv.c file it might be best to put them in a seperate
> file like hv_debugfs.c. This way when we start adding more tests we
> don't bloat the vmbus_drv.c file unnecessarily. The hv_debugfs.c
> file would have the #ifdef CONFIG_HYPERV_TESTING at the top so if
> its not enabled  those null implementations in "hyperv_debugfs.h"
> woud kick in anywhere that included the hyperv_vmbus.h file which
> is what we want.
>=20
> what do you think?
>=20

I'll preface my comments by saying that how code gets structured
into files is always a bit of a judgment call.  The goal is to group code
into sensible chunks to make it easy to understand and to make it
easy to modify and extend later.  The latter is a prediction about the
future, which may or may not be accurate.   For the former, what's
"easy to understand," is often in the eye of the beholder.  So you may
get different opinions from different reviewers.

That said, I like the idea of a separate hv_debugfs.c file to contain
the implementation of the various functions you have added to
provide the fuzzing capability.   I'm less convinced about the value
of a separate hyperv_debugfs.h file.   I think you have one big
#ifdef CONFIG_HYPERV_TESTING followed by the declarations of
the functions in hv_debugfs.c, followed by #else and null
implementations of those functions.  This is 20 lines of code or so,
and could easily go in hyperv_vmbus.h.

For the new hv_debugfs.c, you can avoid the need for
#ifdef CONFIG_HYPERV_TESTING by modifying the Makefile in
drivers/hv so that hv_debugfs.o is built only if CONFIG_HYPERV_TESTING
is defined.  Look at the current Makefile to see how this is done
with CONFIG_HYPERV_UTILS and CONFIG_HYPERV_BALLOON.

Michael


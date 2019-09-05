Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5871AACA6
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2019 22:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfIEUAW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Sep 2019 16:00:22 -0400
Received: from mail-eopbgr1320129.outbound.protection.outlook.com ([40.107.132.129]:34496
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725945AbfIEUAW (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Sep 2019 16:00:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cK+E1iNYT591YhPh0r558dUZ6rfV52Ec6N0rlhNoBFnBCR37bgWsAPN+MP5mAMi70+i/oCZHNsYkE2yrWBXBwi5RawRZib6q0GblYbTi5Dbxqa3qszTlrwPHdQ0/WVMLmPidsAG2fdKq2mH98WVpRFoeomDqX7k2gFxGUAXOPqDHaCEwA6Dt5byYf2iAwPA77v6jA0QQ0kJ5hoezESuHHqH3/Zt7WHsEH32Estr4J2jLWhqucNyDkF3WSwK0Q6Ru9yve1tkFWXYuQ/2XBkbfWa0nt0EMvLv37OXxYaQ4YoyoIv8Nc4O1FP/jvqKSznT5Lx+zoyVGPsWCJ4OIaIZuyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvVfNFhvkBHKqlUBnzZQC3txstf2nOGP79zUTiWLc70=;
 b=dOm/IOXOx0e6ewqAiYjrSJg5TJxKQN9zAosRH3XLRgyUgMO2nM1ZiD/U/ocNybq0Ggnx86peXhwUc4jElxK0Df41LxFQpqp+86RiTcYbwpHuTWamOYzaCIu3P+VBHRUCPvKHrOj9xNKqVrNMN25Nfq2NtKgTaZ2Sb/1IyZajRr5z+fdMsoGDF9DuJFPxmAOASh8KXlCNfkNhPvj9R928eEbpdbLQqBznh4XTfISwCjiHX9ZKnp7QxwiGoD6BuSi/8ztUg1LQYPv75w8zbUqoyaVmSfNZvseBW4x6mcUeZj2qcK9ZMQIyT8P648mm8YsrRGQO0XwX7BxXFzClXXf/tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvVfNFhvkBHKqlUBnzZQC3txstf2nOGP79zUTiWLc70=;
 b=RH81KOEdlCDSrt+hGgG38vQCcjmp/LyjChLjc+zjYma9fJtbY5L/Gno/QdD9FogTH9EllYbrrWoY1gQ3B5fmSmRDJ0W+IwwmMJnOKhips7ebAuOXfvFZWEr1f6GZBkLz0HYbDScf7MTqq20p1HjH/jX8F+pVTcVLGTm3UqbUXfw=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0185.APCP153.PROD.OUTLOOK.COM (10.170.187.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.6; Thu, 5 Sep 2019 19:59:33 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3%4]) with mapi id 15.20.2263.005; Thu, 5 Sep 2019
 19:59:33 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Sasha Levin <sashal@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 01/12] x86/hyper-v: Suspend/resume the hypercall page
 for hibernation
Thread-Topic: [PATCH v4 01/12] x86/hyper-v: Suspend/resume the hypercall page
 for hibernation
Thread-Index: AQHVZADV1Jf6Sio3tUuSYWx4JeBnGKcdZK0Q
Date:   Thu, 5 Sep 2019 19:59:33 +0000
Message-ID: <PU1P153MB016943AE103E3F17FDB51536BFBB0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1567470139-119355-1-git-send-email-decui@microsoft.com>
 <1567470139-119355-2-git-send-email-decui@microsoft.com>
 <20190905154429.GC1616@sasha-vm>
In-Reply-To: <20190905154429.GC1616@sasha-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-05T19:59:31.1640430Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=78e75f95-8f8d-42d6-baef-aed35e0fe2bf;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:a:e50e:d139:3a72:bc8a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7050884b-9a9f-403b-7c1f-08d7323b9278
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0185;
x-ms-traffictypediagnostic: PU1P153MB0185:|PU1P153MB0185:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB0185AF3EB184DF3A2B8B89C1BFBB0@PU1P153MB0185.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(51914003)(189003)(199004)(66476007)(46003)(74316002)(53936002)(54906003)(186003)(229853002)(64756008)(486006)(66446008)(10090500001)(446003)(8676002)(66946007)(66556008)(76116006)(256004)(316002)(14444005)(22452003)(478600001)(81156014)(81166006)(6246003)(10290500003)(6116002)(305945005)(8936002)(6436002)(33656002)(99286004)(86362001)(11346002)(6916009)(71190400001)(7696005)(71200400001)(9686003)(7736002)(2906002)(476003)(52536014)(102836004)(55016002)(25786009)(8990500004)(4326008)(14454004)(76176011)(5660300002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0185;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HozYsa+qzJ+w2uK1UTNZM7/RvKe1SLj3kft143EG360B0WtKvjmhz9cY9HEa2GwTBM8akWCw0GHqHuygsEcdrCuqRTfaJIgl+tbbugmOQk6nv+P9JIVrmTrHTdxtmxv4yjnNKdUdO4FdZUr6HnGFGSUSkOzk8rN6kkjl9ztsk/tKPKSQZqTmAyFnNg+xIqLt6c667TLj+2R8Sru6AjWNL3x44ZrwPZ//X/tFqL4UZacMSyr2TJJxMYknEGtLsALrlvgbKvKbn6XW9f03/4jCOy9etysTsfx93Sj/kCdsgT49qBs0HmJg37JdmHGnApmSi3VJ52iUA5WEvrRqZuzj4A1KqeGC056ZBGYNleUpc3izQ/JcabSi7+OygwXliIOCDISp9gzlO+VcAlmibUndfNxd+YiDkr4uiB4KGAD57yI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7050884b-9a9f-403b-7c1f-08d7323b9278
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 19:59:33.3595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ygc+FO6t0vV7iga+w/uRVIP99pxpRrVPJViE5a7FWxAPBF3RR1gEymZUDkpzbgvOtrjZBXVFQaTefjkV/f8Quw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0185
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Sasha Levin <sashal@kernel.org>
> Sent: Thursday, September 5, 2019 8:44 AM
> On Tue, Sep 03, 2019 at 12:23:16AM +0000, Dexuan Cui wrote:
> >This is needed for hibernation, e.g. when we resume the old kernel, we n=
eed
> >to disable the "current" kernel's hypercall page and then resume the old
> >kernel's.
>=20
> Hi Dexuan,
>=20
> When sending patches upstream, please make sure you send them to all
> maintainers and mailing lists that it needs to go to according to
> MAINTAINERS/get_maintainers.py rather than cherry-picking names off the
> list.
>=20
> This is specially important in subsystems like x86 where it's a group
> maintainers model, and it's very possible that Thomas is sipping
> margaritas on a beach while one of the other x86 maintainers is covering
> the tree.
>=20
> This is quite easy with git-send-email and get_maintainers.py, something
> like this:
>=20
> 	git send-email --cc-cmd=3D"scripts/get_maintainer.pl --separator=3D,
> --no-rolestats" your-work.patch
>=20
> Will do all of that automatically for you.
> Sasha

Thanks for the reminder, Sasha!
I didn't know the very useful parameter of git-send-email. :-)
I'm going to post v5 with the parameter.

BTW, I'll split v4 into 2 patchsets.

Patchset #1 consists of the first 3 patches of v4, and should go through th=
e
tip.git tree (I need to rebase it to the latest timers/core branch due to a=
 conflict).

Patchset #2 consists of the remaining 9 patches and can go through the hype=
rv
tree.

Thanks,
-- Dexuan

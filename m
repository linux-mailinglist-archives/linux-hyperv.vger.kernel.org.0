Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A111BABCD8
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Sep 2019 17:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404530AbfIFPpO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 6 Sep 2019 11:45:14 -0400
Received: from mail-eopbgr820093.outbound.protection.outlook.com ([40.107.82.93]:13088
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392814AbfIFPpN (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 6 Sep 2019 11:45:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkNC+ner05qpQg22/GgjdptqF3fZJ9Eu/ANkD3N9bmCkIQv2KSjb0rAiUPelcfLWBMply+xLII3JVeTZDXHJfHYGa6AcQRx1RCK5P0IlH3yzwJKzC0KhjfMFTy+7zrHJTTUgVhN0C4PgrJqRhJWTWa/ocGkuv5t1UZA8ebq/GxVdFhQwOoN5AVC2urak0ReEwSj2LB4Ux3IEVr7pAjNX7dixqXc9A+cvoyMSW7FtyTBnnXMgrDLjrdFZWegZJ04X5k/Dpg9Bix/Nyuu8KhtBuLypH4F2bQHhRSey+TW9rMbbqMFi4EySkmIogGKgr6OFsz0hhd4Fsh3ZGgPK53G87g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9mSFKhiEWfZ5+OE/Mn+M5DQMe57kqyu4N0lRW9mnFs=;
 b=PvNwEaCorrP5mIqCy+6s3n7lecdOkaazIjoo/7Sy1P9X9gCKoup4oKa5vOxvW2Be6LlHMgdARoQlw2FE2muca1hQJ3tsPDVCVAbOc2iJz+soxlPFelfVOI1wklDbveNoQF+dZnM20HbLdPZmDdyeKWftkyireE4JnbkgoxpTGuFx0dKHt697dPCFRIi7ETJU//0SqxpYjrCY+b/I3vkJUAi0sqdDZnqjU+S9Bp32PsKM4EsdbDwYhKo/+iQo6j7AAx1y4zqw3ubwZwE15YkY7YAw4u/eeHEmgAwmbBZhl7oosIc7K1vEAWAcqCYRSBM6YBaTa/AUoQcZZENtGjlLjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9mSFKhiEWfZ5+OE/Mn+M5DQMe57kqyu4N0lRW9mnFs=;
 b=NIt+eG7L900FijgZ0g/t0CZZByOvR+RKg1JsDB4b9Pqfj4ycRG5UkvCWFbASTikLj8QbMo1KDg3A/ef3kyneqxpI5JD927hBoWgIRmD7688IWZ3CIf0EZuBIr+Esk8iNG08l1Eqve8M7etg8EQqS8Gz6pzkcH/u4wDJ/fog0sSA=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0777.namprd21.prod.outlook.com (10.173.172.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.4; Fri, 6 Sep 2019 15:45:09 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a%7]) with mapi id 15.20.2263.004; Fri, 6 Sep 2019
 15:45:09 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Long Li <longli@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch v3] storvsc: setup 1:1 mapping between hardware queue and
 CPU queue
Thread-Topic: [Patch v3] storvsc: setup 1:1 mapping between hardware queue and
 CPU queue
Thread-Index: AQHVZDzovSuzxYYkAEeci8JFnGV5zKcdtlHwgABJPwCAAMvU8A==
Date:   Fri, 6 Sep 2019 15:45:09 +0000
Message-ID: <DM5PR21MB0137ABFD8778BC94EAFF835ED7BA0@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <1567724073-30192-1-git-send-email-longli@linuxonhyperv.com>
 <DM5PR21MB013716CEE8942CB769E236F2D7BB0@DM5PR21MB0137.namprd21.prod.outlook.com>
 <CY4PR21MB074110983075A3BC91D73AE4CEBA0@CY4PR21MB0741.namprd21.prod.outlook.com>
In-Reply-To: <CY4PR21MB074110983075A3BC91D73AE4CEBA0@CY4PR21MB0741.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-05T23:18:53.2998445Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8c8ad67e-2337-47ff-9485-b53edfd6eb3e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 981ec6ad-ebcc-48b6-ac6a-08d732e13285
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR21MB0777;
x-ms-traffictypediagnostic: DM5PR21MB0777:|DM5PR21MB0777:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB0777B282E1D6294FA3967E2BD7BA0@DM5PR21MB0777.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(199004)(189003)(4744005)(14454004)(2501003)(2201001)(3846002)(6116002)(2906002)(5660300002)(10290500003)(10090500001)(6436002)(229853002)(186003)(446003)(99286004)(305945005)(486006)(74316002)(7736002)(476003)(11346002)(26005)(8990500004)(25786009)(316002)(66446008)(66556008)(76116006)(64756008)(66476007)(22452003)(66066001)(81166006)(81156014)(8676002)(66946007)(6246003)(33656002)(9686003)(55016002)(52536014)(110136005)(102836004)(76176011)(6506007)(7696005)(86362001)(256004)(71190400001)(71200400001)(478600001)(8936002)(53936002)(1511001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0777;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CSm/NAfg21rsImD3DoJH3UylwRHK7sMGIMXaGyGtHLrK8RD97kHiCrS1w2p/RQSTax5mT/RqrP1lZ45GcmclIdiiap6Ezhxu3vvTvpC7Yk1qWpQFPtGeZZ9w0/H7ckzIrvgDwSuQV2er/xKKAefPeRaCLdWXoWr6nKgx91kk6JULlNuUnvoE8u2qTflOxKcbJlPDevD4JyGMfZhY9sE19QFxtirkcPob2pT/ERhYatD0RaBcp52rgs/TkrOA3w8i+qEme6HyJy6/cQV0wQzyPwyF5XZDR2IC9yVKNw3ZdQEoRgWT2vlCAaG9K/v30NxpLG6jVmZnJ5dZfzTnD3v6LSfriRaLXqj0129wiMJjBCC9+FCKXT+FXZFzVQdmmImVYf2KAgTHONcjJb9qfe/tvkep23qRSyxmXAakcJE+9rA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 981ec6ad-ebcc-48b6-ac6a-08d732e13285
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 15:45:09.1076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y6rmFNm9MaEyySNbSHSBmTYagccpFULvLjv2jRYdTMW5iBvipSsCMBHDoVWR12I/RiXC1Wal0onMG47Owge1y79J1YjKmXGOpGEP05JfDmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0777
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com> Sent: Thursday, September 5, 2019 8:35=
 PM
> >>
> >> Changes:
> >> v2: rely on default upper layer function to map queues. (suggested by
> >> Ming Lei
> >> <tom.leiming@gmail.com>)
> >> v3: use num_present_cpus() instead of num_online_cpus(). Hyper-v
> >> doesn't support hot-add CPUs. (suggested by Michael Kelley
> >> <mikelley@microsoft.com>)
> >
> >I've mostly seen the "Changes:" section placed below the "---" so that i=
t
> >doesn't clutter up the commit log.  But maybe there's not a strong
> >requirement one way or the other as I didn't find anything called out in=
 the
> >"Documentation/process"
> >directory.
>=20
> Should I resubmit the patch (but keep it v3)?
>=20

I would say do a quick resubmit as v4 so there's no confusion.

Michael

Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48A2D1498D1
	for <lists+linux-hyperv@lfdr.de>; Sun, 26 Jan 2020 05:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgAZE6I (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 25 Jan 2020 23:58:08 -0500
Received: from mail-mw2nam12on2128.outbound.protection.outlook.com ([40.107.244.128]:15316
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729014AbgAZE6I (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 25 Jan 2020 23:58:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVbe8MbgvV7LiCJ/Xjr/1Q2lv9HlnUryJGElxUz3VFio7vbkpaZEiflt0epApgiGA4J042fX8CohXnvy/HB/9tv0tTzMgEBOhcE6pGbtwIRHWEJMEWfpWVD95OwjwfNLZxJcSdbB7o1p+D5EtG0l56+NMOpZePs0quPm8XqO3uYwYaWjYUIZ9D+MWNmKH+DhADoxmd9Du+5FFOucOOKBHNjIs294/oQu1gbQaRVCaRLLxuRbfRZMvOqdEjVmbR670tzuNn5nVGvEptGcr6SYW9h5zPYSpQQfXJQumcgb1S5OykRu53wVRy2kSCW9wJfrUiqiFVRWi9CyNi2peStsOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05k0rvCIikG4CcKwpBKn/rz0J2Elh/suZ3JtPdbqrz4=;
 b=VAWb+XsPdUbI5M2EtEY57wMzEDVpn7wjYqH0zsyhrk/ykayNbUXTh3Hes7ke4wTu/rXELxdKUpl/PwVvtC+k59cBFCHmvcs7q0/LIha+Zs82bp/M0AwQKczkRJGot6Em79wh9BuGeNTmEglQXgu+tjP/3ARsgnNt/jT0loAT/vQL2MWcGPJ3gl3Gjd8b2N28zypQ2OXuyx4IGudS93Kv/tICwXtFPyMTXrbhr5ZvCz3nQsb0hs/lNIjtn0A93suXzkqK46zyYAX3SAfNGxUKgSGO4INOxpuMWByukzKaTG7ZQATaeNng9pDw0PjndKSxlQvIx+bP0tFUCG0/qnZY0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05k0rvCIikG4CcKwpBKn/rz0J2Elh/suZ3JtPdbqrz4=;
 b=QULcXjLt1Tqk/DpkLpJHRkvmoQFx78jJ4fdc/cn3CeW5o4xNefBGJW9rXaFeX78bZyL62EmFAzytZU5lPWjXgKPj+i3wTsfW8xNhme110y+ZNh+gseW9wfDLM+SWhBLyhCcuaM1IRWK1K1g2KxTFcGt27Qd9WOZjkS1FAybNfvk=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (52.132.149.16) by
 MW2PR2101MB1130.namprd21.prod.outlook.com (52.132.146.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.3; Sun, 26 Jan 2020 04:58:06 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d561:cbc4:f1a:e5fe]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d561:cbc4:f1a:e5fe%9]) with mapi id 15.20.2686.013; Sun, 26 Jan 2020
 04:58:06 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH v3 4/4] hv_utils: Add the support of hibernation
Thread-Topic: [PATCH v3 4/4] hv_utils: Add the support of hibernation
Thread-Index: AQHV07lXkR4lePmrTEKsLXbtKFJpOKf8YrPQ
Date:   Sun, 26 Jan 2020 04:58:05 +0000
Message-ID: <MW2PR2101MB1052D9F0EF326C63EB794489D7080@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1579982036-121722-1-git-send-email-decui@microsoft.com>
 <1579982036-121722-5-git-send-email-decui@microsoft.com>
In-Reply-To: <1579982036-121722-5-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-26T04:58:03.7461471Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5b14c786-7b01-4572-9c03-6a0372eb87ff;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ecc9359-b982-42ce-2962-08d7a21c54d3
x-ms-traffictypediagnostic: MW2PR2101MB1130:|MW2PR2101MB1130:|MW2PR2101MB1130:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB113000DA58B24E1A1232FC63D7080@MW2PR2101MB1130.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 02945962BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(189003)(199004)(7696005)(86362001)(52536014)(76116006)(81166006)(81156014)(66946007)(6506007)(66446008)(64756008)(66556008)(66476007)(8990500004)(8676002)(110136005)(478600001)(316002)(71200400001)(186003)(2906002)(8936002)(5660300002)(10290500003)(55016002)(33656002)(9686003)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1130;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: icV+AtP9wFz5OwlFDl5jEyowAonqSv5NK5s14HA4ni3sMFMGdnK84f7/Am8oWFmEdDhAFwv5/9ODW0voqSBC8RfwNVmcECAxAj/e5un6RABYBtATxULtl6lEUYSlsMY3ZPnkhsAn5yUd17sLuJszMmplhIjLjcvoxg1gXJtwAMaAq581XEcx1BSYuzM3W/nZ1ekXZnhrxNt8yXGS6L1Iyp2n/dQp4KdEgV46/HXAYm3ZV//39uMfD0uz9nHrajk6kHdwlX1RJC550LZze8VAyLr+St56eyX8T078phTF4dmRA5CZRnbR2//6HNEtfJOEnwR6pPksMcoVA4s/7loy1sftjrZjiJ22QUWfvka6fZctjXDv3iSJS/2VZauELyIsEyUPbm1VMtT33Y2VHTdDu+gyjgv2KTIonPBAnlE/yHRoohbf6jcBAdXq85GcIKeX
x-ms-exchange-antispam-messagedata: WC/OXweMh0DZdfFZ1D3ksr4iEU0bu2/P4Cfu8T3IcJfFQEAbtALJBuXPSd8eK/RRtfuWulLMK+VfsfnKkFO9iJ7egJ6/850kMj+n/SgGQP9NbPiu2gutbHZG2hfTcTlPzJC8upK5ibx84rFGa1P68g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ecc9359-b982-42ce-2962-08d7a21c54d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2020 04:58:06.0154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PB4ZiWJu9QbpHpyTNc5R+RqnF0GpXYO5OoHJH8QXc09idyM7vJ+Fc30PjbqKAIsWLiHhO8yFREjHEQu+z6HBsXQpGC7qJ8LfBw/16tE6/gI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1130
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Saturday, January 25, 2020 11:=
54 AM
>=20
> Add util_pre_suspend() and util_pre_resume() for some hv_utils devices
> (e.g. kvp/vss/fcopy), because they need special handling before
> util_suspend() calls vmbus_close().
>=20
> For kvp, all the possible pending work items should be cancelled.
>=20
> For vss and fcopy, some extra clean-up needs to be done, i.e. fake a
> THAW message for hv_vss_daemon and fake a CANCEL_FCOPY message for
> hv_fcopy_daemon, otherwise when the VM resums back, the daemons
> can end up in an inconsistent state (i.e. the file systems are
> frozen but will never be thawed; the file transmitted via fcopy
> may not be complete). Note: there is an extra patch for the daemons:
> "Tools: hv: Reopen the devices if read() or write() returns errors",
> because the hv_utils driver can not guarantee the whole transaction
> finishes completely once util_suspend() starts to run (at this time,
> all the userspace processes are frozen).
>=20
> util_probe() disables channel->callback_event to avoid the race with
> the channel callback.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
>=20
> ---
> Changes in v2:
>     Handles fcopy/vss specially to avoid possible inconsistent states.
>=20
> Changes in v3 (I addressed Michael's comments):
>     Removed unneeded blank lines.
>     Simplified the error handling logic by allocating memory earlier.
>     Added a comment before util_suspend(): when we're in the function,
>       all the userspace processes have been frozen.
>=20
>  drivers/hv/hv_fcopy.c     | 54 +++++++++++++++++++++++++++++++++-
>  drivers/hv/hv_kvp.c       | 43 +++++++++++++++++++++++++--
>  drivers/hv/hv_snapshot.c  | 55 ++++++++++++++++++++++++++++++++--
>  drivers/hv/hv_util.c      | 62 ++++++++++++++++++++++++++++++++++++++-
>  drivers/hv/hyperv_vmbus.h |  6 ++++
>  include/linux/hyperv.h    |  2 ++
>  6 files changed, 216 insertions(+), 6 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

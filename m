Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2361A4A75
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Apr 2020 21:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgDJTc1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Apr 2020 15:32:27 -0400
Received: from mail-dm6nam11on2103.outbound.protection.outlook.com ([40.107.223.103]:7873
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbgDJTc0 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Apr 2020 15:32:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akLwG8yZNpGh9L5k60S/4OlLmuytskVQh1lEro/iyPNBEla/XvjPNAkNw1BXfMLBXR9C/sY5sVmvO5cA5epfJezbJ9ITZpgeuPNCTKz3R5eMUabNkd5XdQh0/FqjrSnvhAe/hAkxdwvVlUKc8F3fnQeLzzPHEUCPvZgm45XuaLNwWli3xVAnsnXe7W03lfCNIkzEVRInmTeXU+FPMBP6RpCVvGenmubGhTGEDgDzCG3EbO14om7MpaL7BTKn+cmxIXFETH8MgRQpe9BMbAcCbBDIJXa91CHAaG8D+y/3mlAE5wYgQLSuzDJNkY5KHM30KjZ+9dq2SHNSVIAjJSl4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfW26hVKyXCzFsKqcFRgFGnPrQh2WbcZpBz2aaWy4qE=;
 b=NqvhNk1WaUR9R202dO3/oLE2HGmTv+r51sK3v/f4PnEhVuvpHtu98+q1XgtKcayBMh6uA9I+mY14r96sL08V2MxjCot2kB+YEYUgblOdgEPXLo9FA6i5CNfiHcnutMXTUu+O5whwsxxulymdbSimCZUexcCYWbl4Ee31xckjoxvPbqG3x557H49hzU+EcD8Hpt7p4u8G96IK6ayAQ7LiEkD55ykLsFwenPblIJ0ncuBNItYNXKpTg4uQzSJcYPHjggs7DEj3d4gZaII03yZTXm7wzgl2NdcE02hicOloSXts0OvFMZVbFbzs4t2YDbVMMvT9WXBtOSQzd2xQJCrtEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfW26hVKyXCzFsKqcFRgFGnPrQh2WbcZpBz2aaWy4qE=;
 b=Siwdwj05Kt1mFSLHHhvNkDJY1e/2Xeqo9SQ0TGOTKPWFki3w0t+1AKBmQJDqbWrjHXNgMytuxzQoZ/sCrwdSsWNLBcwaJB57wVS1YQMGygPoS4wfmvkrqowTmbF9KZrGvVTMksnO7H10gJTh8x8YQj4949inBFqa4FuQa3wyuJU=
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com (2603:10b6:4:9e::16)
 by DM5PR2101MB0903.namprd21.prod.outlook.com (2603:10b6:4:a7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.19; Fri, 10 Apr
 2020 19:32:24 +0000
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::f54c:68f0:35cd:d3a2]) by DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::f54c:68f0:35cd:d3a2%9]) with mapi id 15.20.2921.009; Fri, 10 Apr 2020
 19:32:24 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH 08/11] Drivers: hv: vmbus: Remove the unused HV_LOCALIZED
 channel affinity logic
Thread-Topic: [PATCH 08/11] Drivers: hv: vmbus: Remove the unused HV_LOCALIZED
 channel affinity logic
Thread-Index: AQHWC6iynvnL0MG6OUCX2JGtkJaKI6hyxfWQ
Date:   Fri, 10 Apr 2020 19:32:24 +0000
Message-ID: <DM5PR2101MB1047BB9C783A058F7ED27C8FD7DE0@DM5PR2101MB1047.namprd21.prod.outlook.com>
References: <20200406001514.19876-1-parri.andrea@gmail.com>
 <20200406001514.19876-9-parri.andrea@gmail.com>
In-Reply-To: <20200406001514.19876-9-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-10T19:32:22.0605170Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b4aa41a1-fa51-4099-8e1a-689eca401f89;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a7d7f66c-dcd4-4f77-998e-08d7dd85e574
x-ms-traffictypediagnostic: DM5PR2101MB0903:|DM5PR2101MB0903:|DM5PR2101MB0903:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB0903AD0D0EB21E31FBEACE2CD7DE0@DM5PR2101MB0903.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:551;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR2101MB1047.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(6506007)(7696005)(316002)(8990500004)(2906002)(54906003)(478600001)(86362001)(186003)(110136005)(10290500003)(4744005)(66556008)(82950400001)(82960400001)(71200400001)(55016002)(66946007)(26005)(66446008)(76116006)(64756008)(66476007)(81156014)(8936002)(5660300002)(8676002)(52536014)(33656002)(9686003)(4326008);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bip1Lzv/i3khoP1SbzXj4co0UjVIoewzKyY0asvivrxP5sfsWShZorA5TbFnwvs5ecJy/QScXHTC72OIY+YSO1QzXio3iZzTk7KCj4uKFJ+6WnR+E2V7Tr9ekieioXUgFYy1EB1IWHVTSUIsVmx/qwFtTv+ZzvM7beSLmLNS5jwAs01mbMopPQnTRaPHRtQUgq8O7NslUaNs73tF2PM3gZ99ymkqRZ8tCfLfWanPoD9PADGq2Hh2dLYU8zRpGdRCO+ah/Mcmw2qmRaNfIj4BmfCXphnTm4B09SHGwnLuPtGk2g35Xp9wb3P9U4wNCdDXxPShZawjzE22YdHIl9eBJAWREgo2404pOGHy0wTlLZ/ToaCMfmFVmzJDQcBP25LnKOcwCWDNH4zx1HR5XXkqBAcgDx/1qPr3pc7O2BbISJ3eVeDR4Bw+UpEN9WR50xVJ
x-ms-exchange-antispam-messagedata: KwLEPxQPXpw7cVYABg5me4a7dS6ouHW950d17LVS6NdhnE9p+dhzIFu8FsNjiaaAoJlx0J4r43VB9IqXb7oG5561iR0sD8BR7kMeNt9Hl09IZfRItdXtTcumreNPkW7R5Mh3MqFvJU1zEAqyf/YlDw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d7f66c-dcd4-4f77-998e-08d7dd85e574
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 19:32:24.5177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZeCQ2b7InVz0xQNyBX5pknocl2IjhTjhmWM6ato1yPYG1d4UsP87h3HKQEvJC0q7sn3Z1vxW2HrmQwCDFDFGtFvyUq0WQcUUlAXUpgj8FM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0903
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Sunday, April=
 5, 2020 5:15 PM
>=20
> The logic is unused since commit 509879bdb30b8 ("Drivers: hv: Introduce
> a policy for controlling channel affinity").
>=20
> This logic assumes that a channel target_cpu doesn't change during the
> lifetime of a channel, but this assumption is incompatible with the new
> functionality that allows changing the vCPU a channel will interrupt.
>=20
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/channel_mgmt.c | 105 +++++++++-----------------------------
>  include/linux/hyperv.h    |  27 ----------
>  2 files changed, 25 insertions(+), 107 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

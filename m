Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4DE1FF686
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2020 17:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgFRPYN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Jun 2020 11:24:13 -0400
Received: from mail-eopbgr770118.outbound.protection.outlook.com ([40.107.77.118]:30030
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726905AbgFRPYK (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Jun 2020 11:24:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjF3WmvhzRbY0sfm6q0qMs7YFoKvH4UEL/PCiV3moG9KOhAFiSwgbOFrrt2B2pjBnMz793eihbPe20rcnZ76owFzLcKCokgyIbIfqJ3OHvOriFxtjabET8QVZRAED/eddip6SF4aSq0R7P+ekpaQ0CaMCKN8E4uwh2HM72Y9xZMAF76oEzitDQMFoV34bX/0fwl4OVhTBA4sgfO2r7wptpQICw4YZ+YhEGnpPb/kLpJVkQxMRFYDPo6olAgCzerXIVGI60LLbbkiFFeAm2CerGzVab6UkAnqTDbNxvRzHtcltFVc7ROK/ciyCEn/LLh9Aam1xyGqvoygWbRMt/HCFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0/qrWzubGG9EtOv55Hm5jttac6SlrdJp7ZhsA2bRIU=;
 b=loEEZzIwuDx7KH/AsAgSCMCNDjKH0fQS3pb0TqI8/VAvz8+EWnb4SLf9R+/VpVNjll3coIBeIZ0dj9MC8ZTbFUIDOizzckMs4J8Ku1F8VEIfPq6E+on2oFoMqCWWoSIY0UuJaR1MGPuHugneCvhNONEZQUki5EYo2npAbk2gndI++RLtBMFgbDc3LLUaw5ykvI3h1yiZCwAYkWKGMay0JzZaWvYtkm3aI9NT5r02mZUgjMKiUXOl3lOeHelagynC9gew0i0l6Nf/IY4ejFBFjsj+Ce2tLwvNd9ceDgVp1OJI/YGexNvPMCf7hfMNuHJLE6CRxQjrpMfVA/6u7IARsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0/qrWzubGG9EtOv55Hm5jttac6SlrdJp7ZhsA2bRIU=;
 b=LxMPuUSAdLeS1xx3UpuuDjRJndrZjM/fATuDWP/WTDiNY9IgY+LZWToNb6MaMhGpHhdpItsN2pw/jxToiDfjnQpfAKPqsVbHRF8T3SdQb2XMqw1qU+gGTl2TzAkeBa3rd8G/nEmyBqR+zi+be9DeRMIXlDthhnCoT/WSkABOfuM=
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com (2603:10b6:4:9e::16)
 by DM6PR21MB1290.namprd21.prod.outlook.com (2603:10b6:5:170::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.12; Thu, 18 Jun
 2020 15:24:06 +0000
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::9583:a05a:e040:2923]) by DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::9583:a05a:e040:2923%7]) with mapi id 15.20.3131.008; Thu, 18 Jun 2020
 15:24:06 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/8] Drivers: hv: vmbus: Remove the target_vp field from
 the vmbus_channel struct
Thread-Topic: [PATCH 1/8] Drivers: hv: vmbus: Remove the target_vp field from
 the vmbus_channel struct
Thread-Index: AQHWRMcKu+sQS1ApXkyBzB8+LK3Nrqjefy7Q
Date:   Thu, 18 Jun 2020 15:24:06 +0000
Message-ID: <DM5PR2101MB1047A972A39E3AE03DB9C475D79B0@DM5PR2101MB1047.namprd21.prod.outlook.com>
References: <20200617164642.37393-1-parri.andrea@gmail.com>
 <20200617164642.37393-2-parri.andrea@gmail.com>
In-Reply-To: <20200617164642.37393-2-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-06-18T15:24:04Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0284ff37-f947-4fe5-8140-99e6e6ce0234;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6cd67a1a-d158-4ecc-3485-08d8139ba3f5
x-ms-traffictypediagnostic: DM6PR21MB1290:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR21MB1290304340827F8806E705CCD79B0@DM6PR21MB1290.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UWdvGVKvhskLglEJwPG9ZG4mav7+SVeuuJcByAaZOQIu8kzOfht6Gq3Z4F0XHSsEZ2xrQhCFoEDB/G3o0ty1nthMfX/QB7IjPlo7orkWBl4RgeO3bR6WzV3Y/FNwHj+ilmFEcRcGcqlhyKVw5nZ0ZndAJpOZbhVMG0twk8ntY3PdNqGpo/aP1SNZ644t0LeB2T60yhtb9CfP/Eedt8gYuYY/9rpueJ7sCUTYI7zGpz0mUuzKDoe+36FtV7aVbtHO7TxvBPSDgoJdBlcO4NIBtPVm2+OGAOB6i4CQD7D3Sf5O/TDBvJ2vYwYnsoyOC6HkCm2OrDpedoN5zgycNpOgMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR2101MB1047.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(2906002)(52536014)(5660300002)(33656002)(8936002)(4744005)(66556008)(54906003)(64756008)(66946007)(83380400001)(66446008)(66476007)(55016002)(76116006)(86362001)(110136005)(9686003)(6506007)(82960400001)(82950400001)(71200400001)(478600001)(186003)(4326008)(8990500004)(8676002)(316002)(7696005)(10290500003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: YfMIk/Gze+z89CZwdj79bEqCo+GEivdn5bBKu4lhpwMTj1mv6OBFgoVyr8CvtY84tI7FWvKlNBSE2CNoMUDYwudGkh3bol0zTrsL/AY0kde1S+kV/V7/rBA0rqf2Q/7hcjxBvaB1EpzWoQI9dcxwCb97P2i5dEDdAkbvGhc7EhT0xuehcsETCcobrlcBL+JWfFUO1sB55dn1Rik2AhjBEAavEDpffX4ELUpTH7Ibict4GqCO2g6pzs2tyn5Y6XdV3aiayHrF5piAb8j71URi0x78aBmcz8QqprBInWyzydCA/zvQ2lWFzkvurSnMFRbEIK0RJc2RqF3WUKyUVsiDmXF8qmBzMm/Pak7E2FujV/4iqQ0bIZZgs4ck8UzER8sunNPfboxr4qYNZrhLpgV3zmLRmnyPI4fEGqlmHLvfx97t0EmI9b5W4XmqbGl2U/7/EhoyQZJGs0MJr8XQ7uEGidRNu/qHa7TS7B/A7f2wRY7zfZmMcUwLg9kGRSWtd3Qk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR2101MB1047.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd67a1a-d158-4ecc-3485-08d8139ba3f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 15:24:06.2957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i6fb8cFbKpgDKY3xj3WzHLKY7tEqR2tV2ygCKhWtqps/bkTZVaeu5cC1LBAb4WVzp+pvaeRpH4A6K7a7qvl/A5icUr7hosQStpOXUqlt39w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1290
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Wednesday, Ju=
ne 17, 2020 9:47 AM
>=20
> The field is read only in __vmbus_open() and it is already stored twice
> (after a call to hv_cpu_number_to_vp_number()) in target_cpu_store() and
> init_vp_index(); there is no need to "cache" its value in the channel
> data structure.
>=20
> Suggested-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/channel.c      |  3 ++-
>  drivers/hv/channel_mgmt.c |  3 ---
>  drivers/hv/vmbus_drv.c    |  2 --
>  include/linux/hyperv.h    | 15 +++++++--------
>  4 files changed, 9 insertions(+), 14 deletions(-)

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FB62DDADD
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Dec 2020 22:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgLQVcJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Dec 2020 16:32:09 -0500
Received: from mail-bn8nam08on2121.outbound.protection.outlook.com ([40.107.100.121]:17376
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728336AbgLQVcI (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Dec 2020 16:32:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJARwdxJhi2MTucW71Rrp1kpndSMdNmIpXm4LCzC9HJsnMEvWiJ6zwZMk61PCR09OPOaW5Oaa/8B5WkGEzJZf5zjFhofSj5eidDdG+6dhUD7OjdVpAoWNVof0NdvY7DbAb4WEpBEDMBxlcOIwDTh761iIxEL2xXhpAEU+WNFlhPrTPqgMRk8zrhV6y4QXBZ3B6Z5ZNiaHNNKHBKq9jHyt+cdPN01i14hbhzCxHKxhE7JmkDkD0C0z6fi2A0k5q/n13+Dt2wgO+WJlsyNuxU/VoiHXVVNlal09L/qfpmzPtKvAy/CWBY5ao1LYmPqfIglwN7CUfm+oGpUEiLmiJxfQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ib3kHudg2OQiPHhVugBJf44LQij4H3Z59rCYHMTDMqY=;
 b=FfiOQ197jUqZp7AKL0K2yV2RyLJC0bQXvQr+B7KL8RAkfYkowVK62P6OnmUdDkeTAmeJ8FxF9DpWqLXsVlEccy22X8KwssRQwIjSYkyWHAzA9lHznOHuNWFFUfuUlcKhYqWUNuCbcT1r9qovylUF1CU8LwRPdilnAaV9np1ZA3sdqnEAOYLuMGxr6mFB5dwMCvdy7PvCuTMGtN/BosdLp5pu5Py0JQYWwjKdCdtFxlJtrmPEHI7UHEoRYMd/w05knTSNu3MJaRVzXYIjFvaBPJ+i2r7SWQhleH5cuPdGsJNLNvboFwxzWSwJi9Cag/Ugo4kZiD0+NdnBz6qSwyP1wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ib3kHudg2OQiPHhVugBJf44LQij4H3Z59rCYHMTDMqY=;
 b=M/6t3eu0hST78JrrO3p7dE1/4FgEQuDj4PPypNmGrKj1zHlQBWBmLlhH8Hdd9EN1wFDmbm/VYg6a8zVjtuUxmaaoUcJUZKlQgpACuNz/YlO6RmzIkNxlijEVNsGWzn+RCWsWJtaNOdPqXwHY4Aq2lMiJ6IQ8bmzkCqMp8iNRHTI=
Received: from (2603:10b6:303:74::12) by
 MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.3; Thu, 17 Dec
 2020 21:31:15 +0000
Received: from MW4PR21MB1857.namprd21.prod.outlook.com
 ([fe80::f133:55b5:4633:c485]) by MW4PR21MB1857.namprd21.prod.outlook.com
 ([fe80::f133:55b5:4633:c485%5]) with mapi id 15.20.3700.014; Thu, 17 Dec 2020
 21:31:15 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH 1/3] scsi: storvsc: Fix max_outstanding_req_per_channel
 for Win8 and newer
Thread-Topic: [PATCH 1/3] scsi: storvsc: Fix max_outstanding_req_per_channel
 for Win8 and newer
Thread-Index: AQHW1LPvCXblZaSOtUCrOLiJZky2uan7zR/A
Date:   Thu, 17 Dec 2020 21:31:15 +0000
Message-ID: <MW4PR21MB1857F1B193068A12AD9D7E9ABFC49@MW4PR21MB1857.namprd21.prod.outlook.com>
References: <20201217203321.4539-1-parri.andrea@gmail.com>
 <20201217203321.4539-2-parri.andrea@gmail.com>
In-Reply-To: <20201217203321.4539-2-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3fa860d4-1247-46b2-a7ad-a827cadc343b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-17T21:26:21Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:240f:4d5f:961f:391f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1d3c6225-a926-4529-bce8-08d8a2d315ad
x-ms-traffictypediagnostic: MW2PR2101MB1052:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1052E2A3EC8FC1D71194CFE9BFC49@MW2PR2101MB1052.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jETy0sUMKrzvWQxg5TLmBJWj+cIiWwr7nejcUpDnaP/HPCRHhxMVALFGnfkMX3wM9VCPHfa7ywKsTL06WIR0EHpjjFPF6rr3I1uKXi6E8xd/T5ImvmXuU3npDgJiMT/IQzRnmONWx1ib0mP+0NouPPQQCe+yPgULopPpDdGAH5GVWc0xahLYmcQyTe+7yXIvTUWXC2qoWbocwwzJEVH0UE6Gcwne/jjWMLhPiR6yh2pJMKNprdNm79fTo0Bi3gnqYv2s6IxgP4LfTagvcA6xoAbbBzjjvUOZmPAYvZtbmbxsxrKhG9dgnSEC4kdCFprIMVhCbgC4GGvaLzxM3/JeXHrU/uSee2/dwbvmbvuvbM1aDklGfnoSpFXeEniXY2qy5MftEPKK5KT1M9JqIbF8bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB1857.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(8676002)(478600001)(55016002)(66476007)(66556008)(10290500003)(52536014)(66946007)(9686003)(33656002)(54906003)(5660300002)(66446008)(2906002)(7696005)(6506007)(110136005)(8936002)(4326008)(4744005)(316002)(82950400001)(82960400001)(71200400001)(76116006)(86362001)(186003)(8990500004)(64756008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kLRd0og6dIFe3T7GvGhPvJBm4dLoGvwl4D/BbNY3Te8cpKLmVibRgoszVnBg?=
 =?us-ascii?Q?rgXnm2k1VVcFrM3en3s0o2Ux9H9EqSoNnpc370IBe8OPgfzhNCQERZD4CZtY?=
 =?us-ascii?Q?iTssJEnk3Y8/d+Abnx65QLUW+l897zj/ufo2+r2Xd3/Hc5Mmmmj/84MJ5bqL?=
 =?us-ascii?Q?GwIGvcUwpcdKjfGCvL3/a1xVduGU8foFp3IN8V4RwW5VloX/ZdMrDLCg4rCx?=
 =?us-ascii?Q?Vw6V8qxFriteGg0JqN3uCVAUj1yQookG+r/U9gl4CDDEX23fX+WI0ZwFRSyI?=
 =?us-ascii?Q?vOf/iC6zSly5SyYkLXMBiBNxH/Bw93jbOHJixecbBv4+hyQ1X/idf4lO3LT+?=
 =?us-ascii?Q?yIw8+CKb78+t/0f9Vb1h3BpEUgJ0gqRYcBOy9WcJp1ERYnkA07ww589287D+?=
 =?us-ascii?Q?tNJeZdhDgw8Objss6KmDLUIBg87HvgnqZfs+LzXtwhl0Iiy9JUnz6Q9Gj+ZA?=
 =?us-ascii?Q?Y2Akjnv1l3VEJvrudh6nWuHKFjHQM4WBT2JqtOKGIH88gi5LyBRFmHl8QuyY?=
 =?us-ascii?Q?bzk5tHGlkUYE8f/dvYRBwwouDMkD5UDwjLVQb/6e47J+bEaMrNuOdgGeG7hv?=
 =?us-ascii?Q?bMsv30CSgPe4s00LbZXd5NFfrmNvHKxj0FkRsBjcA8zu322j0j7KHU28UF6V?=
 =?us-ascii?Q?1Pa3SNtpURzRT3kZCPuqWr7W3RDhutiLD1eLbhd+IF9vBCGih+/lQXnlFDTM?=
 =?us-ascii?Q?5QeXfK4ZEoWYKqOH0HeXcNe7WV3Puyrv8mFB/1fEESrwvOVtnj9Q6AmV0hIh?=
 =?us-ascii?Q?GmDQpgdrQd3PuBdgnLbP1Usbm9LfsoGD6wQpIsBsWfbhdU2FzNDy+lxXDEPX?=
 =?us-ascii?Q?jEdUGxOmYeWLv4YbEaDMPCGt0fGPQQtoHFEA86wcnh+p59ltUCTh9DKTb1kh?=
 =?us-ascii?Q?lzln+PsSs4xcUf1LZQ3UQB2VbEEIElHgxS2vb/9HM9YtRCQ6CfRHjdsD2S3f?=
 =?us-ascii?Q?KW6nH4uIaKP7OC0n21SLzYDvl3fc+gDnkm1eKovKPMmkGlGG6UjNTidMSzrt?=
 =?us-ascii?Q?VcDubk601fZiC9skHazhAw2rWosrkrRZswxEPyTyLNoygmQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB1857.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3c6225-a926-4529-bce8-08d8a2d315ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2020 21:31:15.6779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CJqd98+/zJrbtfaiVzbtHrkgb2rnG7aAxg1jbCTE8zU8TP9F5D9gwHV/S7LknYh1LBVWnGTqZM9wVzzgpS4smQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1052
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Sent: Thursday, December 17, 2020 12:33 PM
>=20
> Current code overestimates the value of max_outstanding_req_per_channel
> for Win8 and newer hosts, since vmscsi_size_delta is set to the initial
> value of sizeof(vmscsi_win8_extension) rather than zero.  This may lead
> to wrong decisions when using ring_avail_percent_lowater equals to zero.
> The estimate of max_outstanding_req_per_channel is 'exact' for Win7 and
> older hosts.  A better choice, keeping the algorithm for the estimation
> simple, is to err the other way around, i.e., to underestimate for Win7
> and older but to use the exact value for Win8 and newer.
>=20
> Suggested-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org

Reviewed-by: Dexuan Cui <decui@microsoft.com>


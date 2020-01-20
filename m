Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCD66143216
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2020 20:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgATTVB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 20 Jan 2020 14:21:01 -0500
Received: from mail-eopbgr700096.outbound.protection.outlook.com ([40.107.70.96]:54496
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbgATTVB (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 20 Jan 2020 14:21:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UE4i+A9OxCbEw3Vd6iYeO2trsAwnxvfLETfSXY7zz34ogr5/Kl/nrKbQ2CxeOxYg1YWJAETjZ4xbGA1pDD9plDiT5ljav688f7xjGi2ikON7bwnt1ZXH+vlvJ3cKlCHurXqu4/kKAuHhvzGooS23vLKINJeKRRbvnH+15I0D3+PqmVlttF0JnJ7GLE5WAf33m4KixSoXR1RTkWnn0pvIDIDZOlHCVmZLdX80z9wL2IYo+6QRs0YwQ9zbi0ToneTAmTnvm5So+K7Z00N0SFJGtGMowiaPzIeNNSqFzGbd9U55zE3zoaft1T1x5N0Vw+fOZ6ltc2zm6Dvzdj9GArQrmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3x/2wvarFaafKBA/ncA/914oMiFMpJG3q0P3TNAYR44=;
 b=Rwz16knJcF6ciJcGLLXNttrskAr8z6Ri2ErZzp3Q1L/bW2q4aeQSQcicsf67LCE7zmVX6DtmF6YGodsoUWptpnJ5+ShRAcsYnG0Q4InFJcFlrPvERqpiQlLMU/aAMSE2RFl1dwOi2EQMzxnpAWAuWNjyKnpzamqEaUeh7a/yWNpl9O7g7cIlvKq7A7IHlan7+4TQ4/YbBaNqEqk0kdrHc3soJ57+cWKsQ3dMhEt3PIBePiqSvLyEB+J/izFkzaCmBIogURM5XCPVo+kPRt6N8GypfqMOwjvAlvidXpJ3Rkm2ni9uqT2vAiITSOLpjo4McK1ChhD2CpLxeH8tT5vBYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3x/2wvarFaafKBA/ncA/914oMiFMpJG3q0P3TNAYR44=;
 b=VK1OGTI/vFWyN6VyqUtMIVM4VjyyozcCEEsnaVnpNIcg1ORYng6GzjnTOztP+fOnYFuMP7Rh/sdq3+q/ibmKZcyHO+nb2KTMOevMBQZwExhWlkRxcS7177Bb8wal9qdU41w42hyF7eceGfCJCKaBi+CCmES1iYYCG8fIhhXsMlU=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (52.132.149.16) by
 MW2PR2101MB1019.namprd21.prod.outlook.com (52.132.146.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.5; Mon, 20 Jan 2020 19:20:57 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::f1bb:c094:cb30:ba1f]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::f1bb:c094:cb30:ba1f%6]) with mapi id 15.20.2644.015; Mon, 20 Jan 2020
 19:20:57 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "richardw.yang@linux.intel.com" <richardw.yang@linux.intel.com>,
        "namit@vmware.com" <namit@vmware.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "david@redhat.com" <david@redhat.com>,
        "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        vkuznets <vkuznets@redhat.com>,
        "eric.devolder@oracle.com" <eric.devolder@oracle.com>
Subject: RE: [RFC PATCH V2 1/10] mm/resource: Move child to new resource when
 release mem region.
Thread-Topic: [RFC PATCH V2 1/10] mm/resource: Move child to new resource when
 release mem region.
Thread-Index: AQHVxVvKIEcG+CpTJkitsskMuv0x06f0AGew
Date:   Mon, 20 Jan 2020 19:20:57 +0000
Message-ID: <MW2PR2101MB1052BDB462E010C4BD751FF3D7320@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
 <20200107130950.2983-2-Tianyu.Lan@microsoft.com>
In-Reply-To: <20200107130950.2983-2-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-20T19:20:55.6363731Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5adb0e3c-acc4-4f6e-96b3-346d06c8369d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8cb52244-cf02-466d-e3ea-08d79ddde09a
x-ms-traffictypediagnostic: MW2PR2101MB1019:|MW2PR2101MB1019:|MW2PR2101MB1019:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB1019E57A9481489DB3022FCED7320@MW2PR2101MB1019.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:186;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(189003)(199004)(71200400001)(26005)(6506007)(7696005)(186003)(64756008)(2906002)(33656002)(66556008)(8990500004)(52536014)(66946007)(66446008)(76116006)(66476007)(5660300002)(10290500003)(55016002)(9686003)(54906003)(81166006)(81156014)(110136005)(8676002)(4326008)(8936002)(316002)(7416002)(86362001)(478600001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1019;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WkXMkSM8Vak/HstTZxVuAateHS9+Ng23z0sne4KOtcwjhFzb4aOmtDHhgm7uZM9jkLgg+r+wku/z6Eh9KsdudaNYBCSLwnbvjIEJAJ7nTafRz3wFOqxDX9OJAcOMc4ED4n0nLTawAu/UWNKE7wu6wpFhebqB8X6sc5oi4/3t7/fAmKpDZ8KABryvzkboF42c6hWtb3GSr60NIYkmmCgDTYlWkEPfp+c6z/6zzDmwKSIrsEqaEVMX5VpRqvxQs7grjCTORTLYSppWQ2L9yCEeh8vuI7Cgm4nzkUHekVa2XFH+ZugoNaiknv9tpKGqfqrUSUZHOBQ9y4ynBOoo7YNv0Ijx/IoKoOiIyqZ+J87tS846R1iVCYXmQ41/0sSdMLRWQ1cEMbpSCJGiTWbEXA183mNC0dF3vWcZi2AC/ClgOQEFkdYAJNwb10ykasCjpOkOrQ2h2fHthl0JirUXA9kSokTpGblPgaJ+bgqNESMPFJoILdhqyfGEzcV2RpcKYj36
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb52244-cf02-466d-e3ea-08d79ddde09a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 19:20:57.5816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kRSZpuNq4DFHDlnS054feyjNEPZkIX49eX6wT7wVOw5YfVkZHnrSH4oyBqOgef5UmIh4n+X9l+TiuO3/aI9EA0mWpELMOuN6F9x5cw0d8PE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1019
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com> Sent: Tuesday, January 7, 2020 =
5:10 AM
>=20
> When release mem region, old mem region may be splited to
> two regions. Current allocate new struct resource for high
> end mem region but not move child resources whose ranges are
> in the high end range to new resource. When adjust old mem
> region's range, adjust_resource() detects child region's range
> is out of new range and return error. Move child resources to
> high end resource before adjusting old mem range.

Let me also suggests some wording improvements to the commit message:

When releasing a mem region, the old mem region may need to be
split into two regions.  In this case, the current code allocates the new
region and adjust the original region to specify a smaller range.  But chil=
d
regions that fall into the range of the new region are not moved to that
new region.  Consequently, when running __adjust_resource() on the
original region, it detects that the child region's range is out of the new
range, and returns an error.

Fix this by moving appropriate child resources to the new region before
adjusting the original mem region range.

>=20
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  kernel/resource.c | 38 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 4 deletions(-)
>=20

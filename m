Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04F542567E
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Oct 2021 17:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbhJGPYN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Oct 2021 11:24:13 -0400
Received: from mail-bn7nam10on2125.outbound.protection.outlook.com ([40.107.92.125]:27873
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232533AbhJGPYM (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Oct 2021 11:24:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoLq1/fIWeIrURMLkud1Q9U8fkLCpIUOXutMG+GnUMT/WqNSHE1nc94olDgSp0PnuIGXNjNNripUuF+alGWme2lnRJZGs6OtajV7ehA7kf7x2qxEPiRixVP7gWraO4IuNgzj9BA8tDB9bohWqR+WHm7mWNcVEvqTPIt7I2tI5z3h2omUiG9rOcVcJOXy0d/xBcKYAXcgZu/S2TBlhZCZR16x/lu/RYZ8Z+Zk4o8O1eLDtFV2pIwId34zTeEgPqZrstqIrjkM6YsilgLrl7C7sQLaoTfIcWb5dnw3A+uYlXvj+wv6HAUTef8MGwV7lcB+5+avR7IZR3hQQIz7Q8q5uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9V/AjU0ek6b0sCXquIkYzsa/FtO9AXxybA7AOZym1so=;
 b=oDY+tK40EXrH5ALo9Iz4uzrdng7U2kjpdrV8PhsKXdPxK1UvKYUuykb9Rd8W8sdvAlexXCN6DzqkK3psfFgd1dL1GnQ5P1TmOm5Pnr+VHvQ2+090FnXUBe11ixzzkTN7r5lvX13FUHpPQmnKPXq6M8xsWRHIeu+Nz8TiieJJAlbJ5o7bNcagyqv1Sg7OS0AxFyY6JMx7PvQi84xOdIpY4uh3bY/G2NMN6PcVg208KMVFuekjEjqQsE8R9LzV8Rt5Jg+PVMwWnr4wCil6qZ2rYsrDblnHiKrbFFuQ6zuGJq0uDXdthNTPXJyfytgpKvYKUFUl51d5G+CZoi7b4tWgfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9V/AjU0ek6b0sCXquIkYzsa/FtO9AXxybA7AOZym1so=;
 b=VjEHFCvdnZvj0+IvVDov/AL3VZSx7FzIh3TOwoTpJ4vu4zgumjNYz2ePqnGgtVtka29VX50+ead1+LfavnF2SBRnmPZO4Ax/tsggoE/IkClelk1Uk7VKB9+91ms9qZ9/dTe73S5/5za8Vi6TnBNh1glNqRXyVlTlez2s+pEJoBw=
Received: from MW2SPR01MB07.namprd21.prod.outlook.com (2603:10b6:302:a::17) by
 BL0PR2101MB1777.namprd21.prod.outlook.com (2603:10b6:207:32::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.1; Thu, 7 Oct
 2021 15:22:15 +0000
Received: from MW2SPR01MB07.namprd21.prod.outlook.com
 ([fe80::899d:a1ed:4bd3:1159]) by MW2SPR01MB07.namprd21.prod.outlook.com
 ([fe80::899d:a1ed:4bd3:1159%6]) with mapi id 15.20.4608.003; Thu, 7 Oct 2021
 15:22:14 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Subject: RE: [PATCH v3] scsi: storvsc: Fix validation for unsolicited incoming
 packets
Thread-Topic: [PATCH v3] scsi: storvsc: Fix validation for unsolicited
 incoming packets
Thread-Index: AQHXu3bfZFP6gztYLkmn+PhsgCNhE6vHptNg
Date:   Thu, 7 Oct 2021 15:22:14 +0000
Message-ID: <MW2SPR01MB07E58BE5A2AA1ADDF4302BCAB19@MW2SPR01MB07.namprd21.prod.outlook.com>
References: <20211007122828.469289-1-parri.andrea@gmail.com>
In-Reply-To: <20211007122828.469289-1-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=63d3338d-c697-4bb5-b9cf-db7b49bb914f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-10-07T15:20:35Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d83ce84a-6435-4451-287b-08d989a63e21
x-ms-traffictypediagnostic: BL0PR2101MB1777:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR2101MB1777B5FE5BFB12178031DD58CAB19@BL0PR2101MB1777.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dZeG2P2JWks+j6L5Fp03Q8ug0naN5ZD7uAEZaTRvWVsPNAstwzXLo0l/s6+Ok+8Kg+rei4xdW5/Er0+PPHvXHp4Jg4+BxHpZtPH+fEZUOLqtUlLJD/lpP+fGU0EWH6mrKqlHoDXnlspHRTPzY3CA1S8ZcUqYZTC1bnzPlC/32kAl7U0UiQ53bU/eHslVkV1bFdSRHoomvVGNy24g+qmVg1yD2aT4MXbDGWOR92WjRiiv23mqXk0JE9mNyoXHEKOzvTv7NNs67B2aSr8bXJlaq11/UnRC+Y0Y1K4Jhs9FFYZ5RSU+w2RsLLZeve0Usi/5sUlz2BhTpdIlzHW+del1iOYGbz8KEWwd56pRXZOKY+WWXdNuMz1rW7hXzd4PJ8Hy2oY9c0UeJLKryuBY94Au1A6yYaeGJxysKEPwPQhuS9vRMj5K3/y5Q9r2w1n3PLRsg3jNOX8H7nk4kmudxaLAw8PRknALXJlCLDZc9eHYd22Gk3mdBHAmDXYtmSxwMHNLzDwby2zO6KvWFMLn3HPoUx/HumiVXDq9Lmlp7eNeqpRkhIgFO1aylGOjeihpiGxZ3+Z96aAqfDlcPm3RucU3V5AjNBcpDAQadLlBRjJfGP5J+I183w9RX52sFqx68dBCf78LfPfB7Wup8pmkjJXFOCkNqxRyrIzE3v7efz49zwLek+Mi5Iw/37/WrUhCVj+jFheHWteYfM+4i8EmCJPTog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2SPR01MB07.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(2906002)(5660300002)(8936002)(10290500003)(53546011)(9686003)(52536014)(66476007)(186003)(107886003)(316002)(7696005)(66946007)(6506007)(55016002)(66446008)(71200400001)(82960400001)(66556008)(64756008)(82950400001)(26005)(8676002)(54906003)(76116006)(110136005)(83380400001)(38070700005)(33656002)(86362001)(122000001)(38100700002)(8990500004)(4326008)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CEfOCpjC0OtwQ3Ne4poLrm1do8JKMA5MgyC6DozgHjtYoIED++7Zbpbikx7U?=
 =?us-ascii?Q?DMDzIpu3gtlvwb607KXmdRxulVMB3bi7/z+Misv1QLjsdRgJqvc0cm4Jfnlp?=
 =?us-ascii?Q?5a92Pl2faLfPc0WlomomKq3YJWonXhX1NWCj4BVkBooobCxPhJ8pWjl3Cdtu?=
 =?us-ascii?Q?JZpSudwpTFJBJcNExnZWxM8juO7zUH2hFOkmAy+hIoBuMiFYHdnlT06LzD9+?=
 =?us-ascii?Q?sMdLBfzQ5fzmDgkeafkCSDIkPoRW22KDMNIfzrDp2p0uIWaEdRvTGdJ4RBO3?=
 =?us-ascii?Q?fwS/VNXnRCu4tk7eqJvfg9Nb5iEKs9oso6Y2oB6xYroed97pW3pgIkG+v+Pr?=
 =?us-ascii?Q?9BLrAcjnvB5EZ4ZG8TRYNShNG+dfIFTN+3CQxDv7nwS4BgmCEO3v4tGaqr5v?=
 =?us-ascii?Q?xmnar0sv4WRUB+zpue6kd2lxM0SmBv6tS6+MFC04dimKwBoCk8q5S5e627Uu?=
 =?us-ascii?Q?Sfg/dE0NNH7tOyqBWUGhzV7PD8/7VVkDGBBIysS1ApjWLAP2Z3k0458LDeXq?=
 =?us-ascii?Q?4kb5JBBzdU4UVzO6GYY2n/EeI77udIk/zNtJ0H75xngQh6xGidukD+oPmcao?=
 =?us-ascii?Q?AKNJCySR2OnKphxljWStTNqjYDLm11sZMmDypoY/Mc9embElIP4YdybBU3xn?=
 =?us-ascii?Q?jZoV+XsPMx/hshj4DXLdkMrQJk8qdwScABfM2b39qEnjGZBshH/j3NSah37c?=
 =?us-ascii?Q?q6kDGBFPfT4Zx7t5rlTrwqVCSSvHfaCX0RnGMvJVM4lDGnTEX8pPXFKLQRRy?=
 =?us-ascii?Q?LjHJLvK/tqlo+wt+4gvCEnzae4Lc8j6i1x/u0wuAYjOiuWQoxpVlrT/jbF8E?=
 =?us-ascii?Q?llOvCClfIWll6lsUva9p9qPxjRCpJDUcE3+MRdEm/rsaunbOu5JSbP9U/VAr?=
 =?us-ascii?Q?sdgKGYUjwgsvqcfcvoCL0/9hSAxlqksfeMA7gQrA5e31Vng4jDGDsnL9BEC0?=
 =?us-ascii?Q?UZ1Vnc5Q/nL69qgKZ4iFFMf1oQpo5W/5ZCFpdN7X9uHJdQIKwPlcxavG9COl?=
 =?us-ascii?Q?sRQUBjeME9VAvHozJjPCpNVqUQyxjD6GxM6HhyjrrTemXW2hKvmCa8/DDrP8?=
 =?us-ascii?Q?Md/Y8pX25Kkqs2wqQChVFIoRLxp0mmpxAXFWwvVZ18Y1GrOHqk3l1Jjt8ZEv?=
 =?us-ascii?Q?ydN+OGKDWUTLSZ/eLuDdiSZm8SD5k5X4Ks5lD1iH5Z9w0hWe3N34UC6sdEk4?=
 =?us-ascii?Q?fnQJzTk3PyI2yIZ5YoBVgmc8HzA8/0PPS7+3BPW93z2onDyCPkmKuo8LeaId?=
 =?us-ascii?Q?KxbsX0EltdBELElzJmJC1VDRodYRmTzezkhqCdETy+lSE8dolEn9FcjMGwOu?=
 =?us-ascii?Q?p3mLJ83BDzak+g3u47QmYcRE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2SPR01MB07.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d83ce84a-6435-4451-287b-08d989a63e21
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2021 15:22:14.7543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MuDjVtpKYlTPOuQRbHxHX5iekfqn5NTxcClu8q2/zO4BGLKuqMu3xce5Ha84xfJMQHtQD6RgYzXcCWC9jqEcxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1777
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Sent: Thursday, October 7, 2021 8:28 AM
> To: linux-kernel@vger.kernel.org; linux-hyperv@vger.kernel.org; linux-
> scsi@vger.kernel.org
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> Wei Liu <wei.liu@kernel.org>; James E . J . Bottomley
> <jejb@linux.ibm.com>; Martin K . Petersen <martin.petersen@oracle.com>;
> Michael Kelley <mikelley@microsoft.com>; Andrea Parri (Microsoft)
> <parri.andrea@gmail.com>; Dexuan Cui <decui@microsoft.com>
> Subject: [PATCH v3] scsi: storvsc: Fix validation for unsolicited
> incoming packets
>=20
> The validation on the length of incoming packets performed in
> storvsc_on_channel_callback() does not apply to unsolicited packets with
> ID of 0 sent by Hyper-V.  Adjust the validation for such unsolicited
> packets.
>=20
> Fixes: 91b1b640b834b2 ("scsi: storvsc: Validate length of incoming
> packet in storvsc_on_channel_callback()")
> Reported-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> ---

Thanks.

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>


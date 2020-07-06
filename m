Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CB6215BC9
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jul 2020 18:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbgGFQ3D (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Jul 2020 12:29:03 -0400
Received: from mail-dm6nam11on2102.outbound.protection.outlook.com ([40.107.223.102]:12197
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729293AbgGFQ3C (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Jul 2020 12:29:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8jLMV4RZrUdpK0ftDdYg9Xmsnglr0CN9i0iyGNZ/Hh1BeYVoMZcGJhE2ZBy7ezAFHqMsgquLYUth9cCBoBz11z0q/Fo+mCtIhG5uQLbA5ygP6y+n65AQLS5aA7oN56w7HafginmnjP9XoHF/brayU3JkF/GW9o+/iwdqnCe9QvJu2LH8rZzbFyWstrKHserFAJ1X2j+FXs+n0OW+fL6YGFFWjBHywng0RBMu42s4CArHh607J5ke2q+bJFZm+grRHrUfT9ntCgKH6sbVtuLiNbJoNyXXPYJfBHrqt+WBg6ABUqORlHBz87Cer+xxwLwinTIRR1EdDNuCzzr4r/MMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYD2IzQVsS2Idbz/UWXy0nLMTBDhj3FAUKyGBw8p20w=;
 b=BSraldyCS/zOLqex76T7hppHTsFUg74EcGqJDbATpQbukEGAUDydRCdH3EMhB3i6VqtRmP9UAzrqett8qV0K72rGCalBn3zPQOnNDTYcG97LySYsrCSLGf1B8cRnrSlge3x1C/H+bDsi09P3uNI7le60xfRgReQdvSL8fV9sKGLtugTbOPOE3isEsCGz1A4lu6R39aobiA+3fXi22o6IQtKWx6OGoWhq3PnSlsi0D6KF3cGonSVrBMO4QxdDuRmG628LReiVXcqAdoukt9o/QQE6qNwlSyCBTJHlqQLOmPap6b83j/ig3pVz/xpl1iFZ8Uxf6STKk3qA0PcCi0CtZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYD2IzQVsS2Idbz/UWXy0nLMTBDhj3FAUKyGBw8p20w=;
 b=V+H7t3vXCMAC1G36qAgeaeZwH3c0k7mVInKBUJgUUaQAI5EErv0lxoBoRPEUqEGpvI//a53JKIiqc2n7xFkOGiHNcHa7/se4FHk/CajBEiYHUQrTuKUFoCA58eEZB+cngU4FGz8eIxcc4HhjwmM/M0fScxWcPmzid6z473OxKWo=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1804.namprd21.prod.outlook.com (2603:10b6:302:6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.4; Mon, 6 Jul
 2020 16:28:59 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::fc14:3ca6:8a8:7407%8]) with mapi id 15.20.3174.001; Mon, 6 Jul 2020
 16:28:59 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Andres Beltran <lkmlabelt@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH] scsi: storvsc: Add validation for untrusted Hyper-V
 values
Thread-Topic: [PATCH] scsi: storvsc: Add validation for untrusted Hyper-V
 values
Thread-Index: AQHWU6/XqVhPqUAuZ0O9lX6z7JjJtqj6vZAg
Date:   Mon, 6 Jul 2020 16:28:59 +0000
Message-ID: <MW2PR2101MB1052B40160D7AB1A266C2630D7690@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200706160928.53049-1-lkmlabelt@gmail.com>
In-Reply-To: <20200706160928.53049-1-lkmlabelt@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-07-06T16:28:58Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6d9c2576-b1c2-491a-99d5-69158a4895aa;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 76d189fb-220a-47a8-4e44-08d821c9afff
x-ms-traffictypediagnostic: MW2PR2101MB1804:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1804BD64CEBE2380DF050198D7690@MW2PR2101MB1804.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yO1xl/f4FQCP1Ko7dnrNDsFLyK3p/r3vU2xjVMxYx1+6Pa9VnrqF5agkPkTGkoEWIVY+IvHDRW0ihLnf3Ki4ZFoLk+T9z4AmPCGqJ7jKj654vUtMma86TWGjvQG1ImkNIuvXXEbmAwdHFtB0OyflGttufaVZLej/ke48wWkkRZMN9AR7TfWYBeJ721W/VvyTNkW562AM4skXeAQNPBhIm5vwWML4rvoXJS7/GnUH/486uUtQIwTBMzBiYRbYfpA6rs8GBiCUSpn3NM0ur36I4a0vVW0goUKn7L2FauDErgJ196ZjFYH5ozxw+1/fu+yd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(33656002)(26005)(6506007)(82950400001)(52536014)(110136005)(316002)(82960400001)(54906003)(478600001)(2906002)(4326008)(10290500003)(9686003)(55016002)(186003)(71200400001)(66476007)(66946007)(64756008)(76116006)(66446008)(66556008)(4744005)(5660300002)(7696005)(8990500004)(86362001)(8676002)(83380400001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: keYt6P9NtCZYr3cK8CtYOaDRu5mozTxoOA9kROwhTA3SJtM8AmURCA3NTl+wRD7u1UdMRk7RdfrRJoVV4JEjJwexmcjRYOH4Lbwt8JqNMHbE40ySdscUpwpH0pcUUtZlt/Y6n1nePnSAHhwKQZJwlCRY6yL6eABF3UigekH4LHmfWx0VdbIYxI8LVrGIHk79UdLh/I0bfanyp6YRKGaqKsHBIQwY4f4Gp7OgL+/HWGSIleQ1JW9mvBx68agnPc46pU/7JugpN9QYNitG7ZeEzxoqraulvkveQlHmfFZDquJKZHeDGq3iSnjzwG9Str3TyV4nxdDoSPw3eGNZLhVdr4NzvWFaOZ4Gra+Rm2QsgznDq/6BXWv1LnUrpDklbO8joNC52XIUnjnDIp4D5UD8OjHA9DPvKGLD/sNLSNbppPXeDIh/N+JIEM9pum0jbjpUuHOEEJjCm8fiA4r9XfdBsVyjPez2gzHhsGnEvd6UphKlr0hhe0hqZCZI7q6b29Yx
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d189fb-220a-47a8-4e44-08d821c9afff
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 16:28:59.6053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6grvdq091/jBEw3FXvfSkXUUAP2W8n+EaInGTyDAhrqAseGEeHKxBXC57sHj7I+9OhgYjiC/v0HPKBnFhr/mTeGeh/s5nvpBOvOtbH8I/wM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1804
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andres Beltran <lkmlabelt@gmail.com> Sent: Monday, July 6, 2020 9:09 =
AM
>=20
> For additional robustness in the face of Hyper-V errors or malicious
> behavior, validate all values that originate from packets that
> Hyper-V has sent to the guest. Ensure that invalid values cannot
> cause data being copied out of the bounds of the source buffer
> when calling memcpy. Ensure that outgoing packets do not have any
> leftover guest memory that has not been zeroed out.
>=20
> Cc: James E.J. Bottomley <jejb@linux.ibm.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org
> Signed-off-by: Andres Beltran <lkmlabelt@gmail.com>
> ---
>  drivers/scsi/storvsc_drv.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

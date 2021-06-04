Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516E439AF01
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Jun 2021 02:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhFDAP5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Jun 2021 20:15:57 -0400
Received: from mail-bn8nam12on2125.outbound.protection.outlook.com ([40.107.237.125]:17582
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229576AbhFDAP5 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Jun 2021 20:15:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cj9o/+kJnT4ZgC/owOCoCeO2roZHoj4v+kwB/I/rE+QutCpd2rmvHc4L6AQzUomvqyQygQfpsguJroEmV81n0hM//UmZjVrk07sz4BkHZIxIjP3vwTZN4ZEdU9H3+bu94Zz6fr3lcGrSDNK8/z5b6BlZd54ntEdhX8EbYw9gF90fHH4Lvw8nbvI3uOKzrn2E/HfIjTZHPYtPKNik/6YiqlVKB9Z2Fxl+Vlt/APPAjOsh/ulbZkn5t1F3fjrZVoGm8JcfPhMw1/1kzidPMRatTAcqc5NHyi4joB4ASuSFZb9LU0ikSi0864/+Ys5BMgW2s0NSTQhWEHuko4hv2WNuaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y76RYwsygiyFJ4E/CXBVN+OwwUwMlmRiGIOjNDKKnR4=;
 b=Ys49y7sgLKBE60dUTRGgTGRLMLlfJyMV0evXUdlo6zgyPLcnijeYUxRz6r1ki71NDjhYEGrSXY6qC9JH+Il1hhwHqrm9QvxgNHQmVzJaIt135tmKbWysV2zg9f3v6QEWj5Jq1FmOXXHaoDr1Bc6cSmiytJJosjbWpvj2Od3ED6zx0LQfh6DZHSu01QL0TXZfKmzQS3wMjH21spcMiKwcaDQfQ8Y8USXu/rKQRvMSYd2w9lSpwMAsHzk8NAya+j8n1NwmCbVD4o/p/BxJ5ORbMg0e2fNsQfL54F8wp6oW2SWkY75sZbUqLt6e4qOUPJFtjkQH16Mf2k4io82paUbpkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y76RYwsygiyFJ4E/CXBVN+OwwUwMlmRiGIOjNDKKnR4=;
 b=Yzsp+Erh3NnvFZij0YgMaJYqPCzhAcMsKQSd0DqKihPyXDDnswbIBKmT+UBRxkn/TtoiES2Sefph2OzxNGE2m7ce+BCNPIXwmAM530fCdfqptlotBeugtw6vP9kK3WwgZWzFqmMBxxr8njpwbJTLG5S2CNKCvanYSoid53YQOJY=
Received: from MW4PR21MB2004.namprd21.prod.outlook.com (2603:10b6:303:68::24)
 by MW4PR21MB1860.namprd21.prod.outlook.com (2603:10b6:303:7a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.2; Fri, 4 Jun
 2021 00:14:09 +0000
Received: from MW4PR21MB2004.namprd21.prod.outlook.com
 ([fe80::bd8a:c616:27d:77a2]) by MW4PR21MB2004.namprd21.prod.outlook.com
 ([fe80::bd8a:c616:27d:77a2%8]) with mapi id 15.20.4219.010; Fri, 4 Jun 2021
 00:14:09 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH 1/1] Drivers: hv: Move Hyper-V extended capability check
 to arch neutral code
Thread-Topic: [PATCH 1/1] Drivers: hv: Move Hyper-V extended capability check
 to arch neutral code
Thread-Index: AQHXV/dt754Yd0mslE6VHNCgKiA46KsC+4ow
Date:   Fri, 4 Jun 2021 00:14:09 +0000
Message-ID: <MW4PR21MB20040751A1A5AFF8D6C6FCA3C03B9@MW4PR21MB2004.namprd21.prod.outlook.com>
References: <1622669804-2016-1-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1622669804-2016-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:94c3:1b26:9ddf:659c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e81f4c18-3fd6-408e-9266-08d926edace8
x-ms-traffictypediagnostic: MW4PR21MB1860:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB18600C3F89807C85EDE6634FC03B9@MW4PR21MB1860.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ZwR/KxegWQl4/PKMuMTBC5hQ4vL3+41j4lzaKP167a+QyMwn2t3o9CJWzwHTM1KHfo5dSUiCpnHp+EpSuNr9p0xxjckHOC2EcJtamj/AJWYSFBmB36VwkUWzp94WuV80WoBIyBP4OVam7Zgdkwdbron3N4KKlr+GZLMIZucTgem13ZwDsmulAkZs9xU3aKkH4aepEykR/kxjAqt8j5k+q6o2iY5RWytnTvnogJcIkAOzaDTC7IJCjtv+VRKuj/vq83Q9WnS2PJedL6IMb+lRla9yTkG5BbLjYXc3qdTOytpT8xeMBH6lPUP+YjINhN6RIlu+ZQ17BlxY4SJY7+ejXoTBfyRatxi+gzHAOYip+R0se0/GCXWq/6xgOL+wx0JrLf1aMpM1q/mxtgj0rrCoFNiE6GDU//jQ0+b+TcumzjnmohrY8IgjS7EVtlAvZmD7Jlhl8Yl16qGwqh5aymin0k3YAKAxDGkQpRP7tjzWmolGayPZKOogXKBmcU14YoxQ/C9S/2Za7oT8Cbs0x7/qmGgCuOAKisrwyzlkDrtv4YEyk0TwdG1PcwqW3zTUUg0s3RjVbLIizCb/V+RFSTe1QSaArb0Bzuz4bxj4Sycc0/7MM5j718Jip7nYUck7whYUMziKauTm9ncwPeideo+/w8/q33E2NCmiUlnd0YCwkq0vBbrbbFX0xP+lxc5x1Qy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2004.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(6506007)(52536014)(921005)(83380400001)(9686003)(110136005)(316002)(122000001)(4744005)(71200400001)(8990500004)(33656002)(55016002)(10290500003)(82960400001)(82950400001)(2906002)(7696005)(66476007)(66556008)(64756008)(66446008)(8936002)(86362001)(5660300002)(76116006)(66946007)(8676002)(478600001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cnbDfTYrnlSUISPV+zA3pChNwNM7gb931vFcvNQUkwC4qfnFFEYjaNCHGzic?=
 =?us-ascii?Q?RW7NpClgGv5DWjbob9c+AHG+kCQ41Ck3hPC+iQ9RiJKSgVeo55afkWJveXOE?=
 =?us-ascii?Q?sco8DIiAxkiSWlD4/gXMKLjtPgJ4TZU0PL5eY//AJVwuu5oKwT16rgmBK3Y+?=
 =?us-ascii?Q?5QZXL4vV8xM7JIs825lIDQYEKEcLZNaR3XnG4swXiMnKN6hQGzG4gbCs6P6g?=
 =?us-ascii?Q?r72StxVNy8MirYkh6pxsu3RIENMVtLmuNrhYZFPTZwfh37wYe1+pGAxX5FaN?=
 =?us-ascii?Q?rxml/7zE9nF32o3mQ2Jvfet1awdt7H17lzBMBxvZw8tY2JD6LZNy772hGZg4?=
 =?us-ascii?Q?d1fmIQlMdEZiewMHOnXFqvh3gHJYrZKpcBBBSElNpaIZm5gPREM4KKbC4K0A?=
 =?us-ascii?Q?HS7O4XUfC9navZBr0vNVHMtTANbnxZLUpJL4tUh9m0PItgiX1d11fPgujcZo?=
 =?us-ascii?Q?V5XQcrts/W7ctKLTomPMqoExuu8Lpc80saFXHMy6W90nOJCcx1qXUR36GWjy?=
 =?us-ascii?Q?EIQMvpdJS7eA0X3YApYjewj6O81a03diPIDbdviwaySOIsuZNAEaIOU6xBrm?=
 =?us-ascii?Q?fwaGnZECQIVCeVxEuUgJQNQgka8AoUJrwMnw4wRQltgGbViKMo/1PYx4nH1X?=
 =?us-ascii?Q?ryhZgEWOpd2T/VUTEhSjjQK1YZVX3vmfvAO0tXfbp6eXjZG7exBz8lcCkOGO?=
 =?us-ascii?Q?oW9Gz9ABq3MzAn0LtzidrpByKO1k8PxrYqzol3YwVIEChKsQY31QBhhuWedx?=
 =?us-ascii?Q?SjOn57cOBIfhVPq77GgBCDRbRgXlzQh6pPaynyvwNQ+ScJFec2NnaLHeaXiW?=
 =?us-ascii?Q?Vvw2Nj7wYA4C1DTBhCqAwqxPUw3kjqbUHzcOMAtF9vIA80FvgE49F4W6lWo7?=
 =?us-ascii?Q?aPQc0nMoNHKzvcMPpiUQPlHPQRD/+zU/kUTLB/qVeA8dZmIReMQnW4kWeZn5?=
 =?us-ascii?Q?NjPva2gkPG+80FGI3tuhBrIvM8ZR7ngynybrZNTwSRS3uBa32xYSrr2Ze5Jq?=
 =?us-ascii?Q?EImWb7dRyvUrerm0wICCRkYADcUzWkFrDeKVKXh1tB6x0afsY4beExfJNw+m?=
 =?us-ascii?Q?8fkn7FVIYZ/37BREFpkuZHx9XHsStopXuETTWqxNJfcq2iWpYWK7om50UfXX?=
 =?us-ascii?Q?ktstrXsuiUS9Zf0PCFeoJS5Mdiddo6mlpoC9JxvIrZisdZRJl1XRCsX6iZKX?=
 =?us-ascii?Q?liXgirbuI+8NvBAHiUv8GqryxZIt/HInzPoCXdBm7I/Cx137Q0QwjLWpmN6j?=
 =?us-ascii?Q?OfqKsdeuMsqMms+rC04xK4MFB3cie6kagmJ2eSH+93ZMM3QDoprs1RG8oPI/?=
 =?us-ascii?Q?zrnqRjh7yK06KJ+8igxuzDvAWFOlYiYQYdLViXbyh3ji7ouwht+iO8J+AMUR?=
 =?us-ascii?Q?3t1SLEVKJgKQcsS3zpR3biuDFr1f?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2004.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e81f4c18-3fd6-408e-9266-08d926edace8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 00:14:09.8588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZzYDIw8i9d3gbfNicN5xMdBs7e+2SFimDNwp4dPDbWKg+WKHcdoroy8Gitn2XIGr6spOaAkIkzeSHEzwUiUK5dwtNGiftmBm87JYdx6Crw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1860
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> The extended capability query code is currently under arch/x86, but it
> is architecture neutral, and is used by arch neutral code in the Hyper-V
> balloon driver. Hence the balloon driver fails to build on other
> architectures.
>=20
> Fix by moving the ext cap code out from arch/x86.  Because it is also
> called from built-in architecture specific code, it can't be in a module,
> so the Makefile treats as built-in even when CONFIG_HYPERV is "m".  Also
> drivers/Makefile is tweaked because this is the first occurrence of a
> Hyper-V file that is built-in even when CONFIG_HYPERV is "m".
>=20
> While here, update the hypercall status check to use the new helper
> function instead of open coding. No functional change.
>=20

Thanks for taking care of this, Michael.

Reviewed-by: Sunil Muthuswamy <sunilmut@microsoft.com>



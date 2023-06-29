Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FEB74304E
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jun 2023 00:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjF2WSA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 29 Jun 2023 18:18:00 -0400
Received: from mail-dm6nam12on2125.outbound.protection.outlook.com ([40.107.243.125]:47200
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229668AbjF2WR7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Jun 2023 18:17:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkwA+0t3Q7Nd/WbbdgZogc7eohCa/TcX6RvEP0EYV+5cG/M4p9tlYSmbR0BdDtLEpv7W70AKFmcuN/zsyX59UHGigM4q+ijZsM2JwbG+4XhrSMjM7YDl3vDQUz3ViDQ+xsZwpFPgwIu3SojSKaoOlaDF18Pb2X8C90PpyD0zNJqeawODi2F3E2qrjwOfmZBVwInUTUFThSnLrr3gk2s8FkuTKsKJOTdP2PJS1vPgEI+RePq2+0NQUYY7wc6tswZ4/r1hWe7m/cKPwlZWGUZYSG5pSo6jxN+mLfCmz4vi0GR2OZLogv4CbYIVomtHksdrYWfY+4AEo/mzveyVeOH9DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hG2uVI7LgEoKcdLePGupiLCIVx/+FXZEBDYhfc8j7WA=;
 b=cqsbkjz7BcXA1SqYUrIbjbwZEleFCx63drU5ERRiQ8bld8+bq+Emh3Ueb2epkV7WN7FKyFPa2WVPgndWXcQxc0yMyeXYDzPqvhhCok+gRNKHsvMwAWlEOKL6b+gLIQQO1yXZ4RGso0C0Mmiweda3e5UpWof6EVWzIsMo0eTVdDWSePY+aSDZviqcus0ADCLk7jAWsIqds5VFmo6pRZ6TXQQ9vTAu27nqugUVqf9qVKNzS3qjkNi2AF/lL2C+5Wyf33kYddBbLssULCX1Vuqj3cZzrlsuz2adMs3/nV6r4mLGiz9uqZOqunX4wQVxubqw2ndjmnTkTSmGUog5V70GUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hG2uVI7LgEoKcdLePGupiLCIVx/+FXZEBDYhfc8j7WA=;
 b=Up4RbL/wALLqh3QAxp6VVk2m+WhlTdrpKpWVkLSz//iWkqnEQ0TIJk12aEzRfePeYLnZfK4C+aH4FKt8babBTCMKvHmRN5YiObm2eiRKKvHgmO80C3m6ii4bBNn8SKUyUCQxX1ezGE/UvUUmLBAYT3GxKUHBX+/MZAtJsuWUuZY=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by IA1PR21MB3472.namprd21.prod.outlook.com (2603:10b6:208:3e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.4; Thu, 29 Jun
 2023 22:17:56 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b%3]) with mapi id 15.20.6565.005; Thu, 29 Jun 2023
 22:17:55 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Sasha Levin <sashal@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH AUTOSEL 6.3 06/17] x86/hyperv: Fix hyperv_pcpu_input_arg
 handling when CPUs go online/offline
Thread-Topic: [PATCH AUTOSEL 6.3 06/17] x86/hyperv: Fix hyperv_pcpu_input_arg
 handling when CPUs go online/offline
Thread-Index: AQHZqrwWcjqR+wRWZ0++rNctZpzODK+iWMLg
Date:   Thu, 29 Jun 2023 22:17:55 +0000
Message-ID: <BYAPR21MB1688BE88DEF635EE690E8832D725A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230629190049.907558-1-sashal@kernel.org>
 <20230629190049.907558-6-sashal@kernel.org>
In-Reply-To: <20230629190049.907558-6-sashal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d2128d2c-2e31-455a-825f-8642eb26bfb4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-29T22:14:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|IA1PR21MB3472:EE_
x-ms-office365-filtering-correlation-id: e2a8f4ba-3f04-49b7-0fe1-08db78eeb052
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J3E0PU7LgKq1tkgMFZmRDBJnxlXZ3MWrDxnoxLxZb34SmisPOfdV677ItZ0eechUODZZsSo93oKvG0F978m1YyqKLH57JfOaIgbm9LzbcUOvAFQ3WifK+bt9V/OIdOCsCSATTBV0CHTIth8K5F4G1+rYw4mPHgxiNjLatHObK3bON72dTxj1IOYXTSOSX0hFmwlsOqCiMEla2kkvojhaMcmtOex3f9uBRjJxzQJsdM8v9I5QPFowAGre64bWvJ5OH2Z2kBEmSUSKP8ULnYaVY3cg7C4XdEIcWlKxEI26Zl3snWRE8N0L66pDgo9WZJLbuBRC2veSAKHtSQomjdHH8/ltpLQwFr5WS7I/xsi5fEAHdqmA6wrw9t1xtHM47Hoi3oBSMhmXHva6q6EnJbip9SyvgdEVcyTVkdrUuF/ZxHhfFiwtbOP+5MzoKixRosblaQOZcsPXYgVl/0HTGNh3WLFYbQDblj+P1gP0wZcsm32TKVersHNmwaz8yZGGe71vEYGKOOskOpuok90mFhy/Aoal6z0w0/01yVFjPZWYLmcRlrflNCetpcuAJ1sFw0yUAEUZDh1X27Qjut+I6oTHBcDaj4yPDjvnNKYItQ7cA7FrXUlO13YV+TRkjQxB3bOaJcJDtJ3MKhNJcX1jZgyipXjPrVpPL0qArSOi5kyWQ1A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199021)(9686003)(186003)(26005)(6506007)(41300700001)(7696005)(83380400001)(478600001)(10290500003)(110136005)(82960400001)(82950400001)(54906003)(71200400001)(122000001)(38100700002)(64756008)(66556008)(55016003)(66476007)(66446008)(76116006)(66946007)(4326008)(316002)(5660300002)(7416002)(52536014)(86362001)(33656002)(4744005)(38070700005)(2906002)(8676002)(8936002)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H5dzbtEWzMFD5R8TYMgKrPC+eCC/DhtuqjR7vQF0AkdHwTAhLi5h1M80SeyH?=
 =?us-ascii?Q?0BoYelF7uWiiu5A5ikeOp1K15Fl7Rz9sL4krCMnyGhQ7kun1xT5DVhx2tkQQ?=
 =?us-ascii?Q?8kU/mfuxAn10XA15zZ4U2oCWy2SYgZGcurL0clluI2RDKQj78d0RvLjZCyhp?=
 =?us-ascii?Q?9/mpK2yD99rYId5zc2qjcmafDSc1BQs3OXu3+uWpJEpbcaVCeuNjisZDrZMl?=
 =?us-ascii?Q?88IXCSZxZ0/OgVYf2Gmh1TEnTtqpLmKDTqDN5MlWN3A1VqdDjWhDjZYDaVdB?=
 =?us-ascii?Q?p2dc83DraL3B++U6W9u+oqhu0gvSfDcqRoXcCHwHTsOuZD8K/atmUu/rtWAA?=
 =?us-ascii?Q?9bDymX5/OFhZXnKmLgVQCalBKG4winqdxEUT63yiSLTwx9wEbLbY0HzxSVVK?=
 =?us-ascii?Q?aO/r7gvfQx4xxPJvjpTAjJsPAnw8LN9E4w3EEGPzZpWESK3lJRSRgeqcQawb?=
 =?us-ascii?Q?NiaUmF5RpTEBuNbokA6/9x0kyesTWeVu6Rfns5/GC5mmY+NgZElDDoxQg/YF?=
 =?us-ascii?Q?xOALs7N+b/7W1r0ntIUw6snLIsEH7ThkNBmhyt5PTMZFG5Tl6LHLkSH3gdQw?=
 =?us-ascii?Q?nGC0y09RC5W0+EHXqXCg4pFMjUdTLK/hlUeaFg9Hz5pMhH2lEpQ4GeTgmid9?=
 =?us-ascii?Q?Lv5raJ5McX+wcNMgo/ZgF5oS12QcwkGVFGzr+5pWg7a4Wdq57EVqs9dq8TeA?=
 =?us-ascii?Q?8RveEm2LBXsMAnjwmwi+VcgF14TxoiMmKXMi7ie4WNACCGgxIkkMUDyKebRR?=
 =?us-ascii?Q?yVQRnfU6Ls8ln7buuKOu9fe8JJOcU51GWf88iOAS/EVQUBRSJE8m9BBNF0so?=
 =?us-ascii?Q?mcQaGbTsdpKPJUeO2TjTBYe/4ntSaoxkOsDhy4gOIRZMcYlaQAXMRMkF1nPc?=
 =?us-ascii?Q?oAjeuwZwZl+d1nb4BEYSs5ZhP/pDcAcpMIEIcHs63U19gLB6A1Uc3Fsp6SSK?=
 =?us-ascii?Q?UOW9rlmEWwiBQ58Qi53MuZgnO0GiYASw6wlP8H1mQs80ByOXDOKU87A4emlN?=
 =?us-ascii?Q?wKlaKzUMlYsykqmGqopo7vFTJEXyQTr/I8BJ3DU4lBc0zMl/A+f+zUbbKxrX?=
 =?us-ascii?Q?HXMiuTFBgPMN9KioQZWe0BLBBTcSOIIJpHwyxkWACKVQjndt4HerN3jDI3bH?=
 =?us-ascii?Q?LgY0lM01iqDtQz6anczQlJKNJQmh2z0fAQMTV8BaIVdEvVMVyB7c6Sr/Xx/0?=
 =?us-ascii?Q?LiC8+4IC2V5KmpY98l44OPD3f7wS0ueUyuvicxvhBQfRKOPekiA5hUul1hDE?=
 =?us-ascii?Q?d6YOuJgjO1mvOkKgIrXg41Y9EnhqWD4vwTb7/dKp6Yfh0xZ0JHgpAP6AZ9bm?=
 =?us-ascii?Q?sUlZxFLEpD6oigijv2xLjc6hbjkKjPRap5CSBgWD0tTd6u+S06GI9yvMJPDM?=
 =?us-ascii?Q?ABN18jKr0Bw9W6Hsm33TS3Nmp2Si4FOitf5kiI5/4G2lx1jxXbJ5rkeqbuom?=
 =?us-ascii?Q?EA/3iCNX06ZZdWvfzSk4dLR91TnkdfCMbSwY9AHLjC1/brYCFpdPJPa/l3UW?=
 =?us-ascii?Q?Naf8NZoVxCAnqpbUjfDeE1ZnEFtXV7Z3Doi8Rhdv//CVd6bBMNWIAH6RHRnw?=
 =?us-ascii?Q?igAtvlfqzIWwYYk8uy+bU0bpUkEuy5Lc+P5wTEuzdUX1NplfKCdtmRgw2U2R?=
 =?us-ascii?Q?wg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a8f4ba-3f04-49b7-0fe1-08db78eeb052
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 22:17:55.8435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J5+NGFy8/N6is6d7KgFp4CkoalpwAjj/kqddyKTe9/BRGkiozy+hBUGsJ0BbTzq04mFPff91vWJgp6sh8qd1zKFLRoj2SJ/AAqysH5iJY/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3472
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Sasha Levin <sashal@kernel.org> Sent: Thursday, June 29, 2023 12:01 P=
M
>=20
> From: Michael Kelley <mikelley@microsoft.com>
>=20
> [ Upstream commit 9636be85cc5bdd8b7a7f6a53405cbcc52161c93c ]
>=20
> These commits
>=20
> a494aef23dfc ("PCI: hv: Replace retarget_msi_interrupt_params with
> hyperv_pcpu_input_arg")
> 2c6ba4216844 ("PCI: hv: Enable PCI pass-thru devices in Confidential VMs"=
)
>=20
> update the Hyper-V virtual PCI driver to use the hyperv_pcpu_input_arg
> because that memory will be correctly marked as decrypted or encrypted
> for all VM types (CoCo or normal). But problems ensue when CPUs in the
> VM go online or offline after virtual PCI devices have been configured.

The two mentioned commits first appeared in 6.4.  So the problem fixed
by this patch doesn't occur with 6.3 and earlier.  There's no need to backp=
ort
this patch to stable releases.

Michael

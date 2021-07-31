Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7D53DC1D0
	for <lists+linux-hyperv@lfdr.de>; Sat, 31 Jul 2021 02:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbhGaAMy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 30 Jul 2021 20:12:54 -0400
Received: from mail-bn8nam08on2098.outbound.protection.outlook.com ([40.107.100.98]:42464
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231355AbhGaAMx (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 30 Jul 2021 20:12:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krHq3RwMu8liBmw/5R7EyA858u67QSfJ45M0llbIVYJva8Axqlfmw4mOziGjkaE6t0eNW/x6BhnHpGuYg6ld667oyQ32sE5gZQu7+RGdjLugO56dzdUcdwv9Hv6FGhOwZXUFudP+Xa4MMpNR8akRbrwroJHdZeUe6SGUv2TRr8hcdJfRqMlsKZYgJ2tgM7xFHdaDBROyr1+6UiwV1Gag5esfn1WDq5dDLciXQQl6LLXge8P8+6OmAd5++bUzohb3J7hpyjpb/9kShg4kPoqo3h94QsUaVl37kIrMlc9MkWi4AsvZyeWavannPCtZPACaPb7P4anhXwcNQRBih6UtNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5oDjnR9JBhd+RUTMlhuAxhatuwcwuKB3B6XT7XDZz8=;
 b=AufLw1SIO4nKYlrkrXWXr0uMi6qMPysgm2CI67GSVrfC8rzRJNUCgJfyG1xJnUrqWsS27JxehRbnk0zObJBmVSZM+rMf13meRdUnA9Sfqk+CapLEqUi0/gzqW9Gd1lIyod4pxTRpZknI2ZS2aTtE5gxWLYGHabdppEUA70m+V2luZv+8VKXMn4c1+VrPY0FslG5bt1zFrbU1JrmsIf1ua6m9Hz3Farr7+IoZW0AjxxsV7W6X0/7t0BJYKMJf5/izJA9q68hkiCIjLMiJawQbYkepM0Rax12OKG2GtE56Rm8lCKXYpFjdY2sALyaXRSLblJEDOl5pBmcbeW9vZodg9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5oDjnR9JBhd+RUTMlhuAxhatuwcwuKB3B6XT7XDZz8=;
 b=ZvxmzqGxUA6Lf0Lwd194xMvo0DBGL6qiDicF89MHQcZp9jVj+qk3oZ89wKUfJNrURUWuEMOBoY1qLvqpjM0M7h3xC0ZokQDpNqg3j7y6Xr47gSMcc8U9xMfYvpAjLu0LPeuX27dQD5K2NzIz480V/QhlK4KWoi7AQWN7J7aGPWQ=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MW2PR2101MB1130.namprd21.prod.outlook.com (2603:10b6:302:4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.2; Sat, 31 Jul
 2021 00:12:45 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::292a:eeea:ee64:3f51]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::292a:eeea:ee64:3f51%4]) with mapi id 15.20.4394.012; Sat, 31 Jul 2021
 00:12:45 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "viremana@linux.microsoft.com" <viremana@linux.microsoft.com>,
        "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>
Subject: RE: [PATCH v4] hyperv: root partition faults writing to VP ASSIST MSR
 PAGE
Thread-Topic: [PATCH v4] hyperv: root partition faults writing to VP ASSIST
 MSR PAGE
Thread-Index: AQHXhWXjNWmxIS5YjUS2UQiuiH/FdKtcNdJw
Date:   Sat, 31 Jul 2021 00:12:45 +0000
Message-ID: <MW4PR21MB200206D615DEE60044B1F0A6C0ED9@MW4PR21MB2002.namprd21.prod.outlook.com>
References: <20210730171056.2820-1-kumarpraveen@linux.microsoft.com>
In-Reply-To: <20210730171056.2820-1-kumarpraveen@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54600535-a7e4-4d82-4869-08d953b7ec16
x-ms-traffictypediagnostic: MW2PR2101MB1130:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1130CE74E4CBD2BEC472AF06C0ED9@MW2PR2101MB1130.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Icg+yLD9ZreM4dxLn9GOHyOcG8PVUIzB6E8jYNuJXxlUcvOHW8QwlPkmVJGHq16Bn+yeMkxgmoWvDlP2aoVTd7sHoPrrFYoMFAWb5vsIpYzIvKP/hG2IDBSi+M+WgASQ/Ob5jI2dCucvocqiIfdY2wS0VQffAlqSM7iU4I4AYzTQpiTJchsHCCipVdot69jbUxUlpqbRMHY99BXM+8XfG6vfbiMUgBC1/vcmO7/bOthhwbd5An+50xdFU79twHJa1tVemYiPlKYNBs0L22Cx+M79bYDWEkXAtE8SiQD6jTK9oyURv2ce0lMJewDIDISTqxQ8hmQ+sfk+fS+ItbLG2D+3rSBF2CfGIP3XQ3bS3qyxIMs1C5SjR4fBj116ErlDxfWKQAQ0azo1k12F02Cq2B21xiVSsMBxAbB441OGinc/KV95vGR/Nqmg6bHjs6cWcIXgNaT1ShSgG+UNkglOuGn+EONBq8OcxcLB/0PHr0K+Q0DUxy+8hN21BBonUwnL6n0cN+TMLKxAD++ClPSZvMw/vOsur27t3y+XxhVZnSz5fsTxUOSaF+Q5qz00v7ca9lkzxOv5/HwNLQQ98TIA3GpkEUT4tTujM4cpClWrc0A3yE8r0kxETzoVfH6zi1+bpTa3Nmgrp63t6gj0Ts19hpi+VoBa5vCKgvJuUoY5ab8VhsoSTNGQr3VCnd4W8IIygNDs2xhjgADII6Z1oEYWRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(107886003)(6506007)(66946007)(316002)(38070700005)(55016002)(38100700002)(71200400001)(52536014)(54906003)(122000001)(76116006)(10290500003)(7696005)(2906002)(64756008)(8676002)(66446008)(66556008)(5660300002)(4326008)(508600001)(26005)(186003)(86362001)(4744005)(8990500004)(33656002)(66476007)(110136005)(8936002)(82960400001)(82950400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YydDI7CuETu+Jz7ouGO34aFlu3fqcFnCMXi3s1q3//od13Z8dNZbw8kXSq0y?=
 =?us-ascii?Q?AOiao7QZiPHTnsVefe5wyyxF77z8PugwAPeZNluA/QObVGW7xm3t2XJK3k+u?=
 =?us-ascii?Q?MK6u/L/KXXlc3sKbeLP78muj6QS8Db+NhMDpjSNNywWwYHDTZC9eBh2K+efb?=
 =?us-ascii?Q?IUK67CZuBFnT8l4UTxLA4Owbh50MWEvmQKJoRkNbwPMwNmetz14RBibFpPRo?=
 =?us-ascii?Q?cJnBWPI1VE+iLplH89tCkiua4V1WHkglRdhxGKUiGI034seKWUaveiOkdH6G?=
 =?us-ascii?Q?x0KPI++D69muVir+S+P7S40AMr7IOC1rWzAhJ3Ph6JYyenYytUfUTi0CiU9q?=
 =?us-ascii?Q?F7wVxZTwY+CTSg6PCCw6k0//WFlRV/5OtkazK7oAtyh3WmFwrzCg1L9Mxjwx?=
 =?us-ascii?Q?UO89Ee2eDPodG6XzyvSl/cYbFneYl3liaxxu21hOfxE3oHAIdsCrOv+1o6GI?=
 =?us-ascii?Q?2+CWrxVu/OwXjAlYMAr4MzEIb2itBnpaTxYmwu37D9Phj+nADfBwvuuyefsI?=
 =?us-ascii?Q?QrkEhFsuD8w56SL1RA7+YUwhMZTeLbW7wwXLwTXW6j5EZYygOICx6v5kZUzZ?=
 =?us-ascii?Q?Ra8h8wxltAN7mSmLFT67+Ci0CRQ68V36GWsrPxnJCx1eeH6E/l2HN9OMAozl?=
 =?us-ascii?Q?rWqB75B93UElzlnO0C10CL9JC5tvCXSWP0Qi/2qeqX8wGhYOug4oAPUTyN65?=
 =?us-ascii?Q?uJwoCSI5GtIltsb3zeUfdgU/kyRyQ9jQBTLJa131+QXSBFalE7wjMdWq0dOH?=
 =?us-ascii?Q?QcRqRfn1+wgW9QJrjHA2WP288vDEq4hJ613IYFfcPqX9SshAAugapZ/KZRbl?=
 =?us-ascii?Q?tVrl4G4tz5fMLvR8EsxfNdsUc2ZNZ85Zs+0Rm/iB30qbujR+hGlUd4G2QcG3?=
 =?us-ascii?Q?ggdXi2vPOI7+xyXqyn3Gm9cRuszVNQhl4bExwRSYtVKKYlviciUJTJpDy7Te?=
 =?us-ascii?Q?dd4IYG9kcT28Qj1ToAQM1pLYQzYC4eUwKXpTaubtA3+FYd+pJAkuwHM96B+t?=
 =?us-ascii?Q?bNu2A9AHQvPSsUyCwiTEU+MUqn8/kp/ihz9WCx1KIoXAQ4x76tSOvDvEmjef?=
 =?us-ascii?Q?tdUvHRhPt9DwKOGwDyX1hH0T+Ib/VBcmJsBjwyV/Tt7AOzL5te/o+FJe1mli?=
 =?us-ascii?Q?PIvb9rv6feUkfTopiCqaKQIKFyr2NKvkiE0Qf15d+ZgoWHcAmuuZaWn9JvCO?=
 =?us-ascii?Q?ydTYABUyrA1/52E8QE3gsSjLyHp7EKj9WjlQJ5gf9c9G5korrpEL9saLpo2c?=
 =?us-ascii?Q?Nr2el3c0/izYUu/vWuA06CwxmJLWGiZdQgzzP8t8vFKu4Jkn/uFxJ+WzYVhS?=
 =?us-ascii?Q?dso=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54600535-a7e4-4d82-4869-08d953b7ec16
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2021 00:12:45.4131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t/7dsbAhcmuJLt5pif/6g6wxK1e1I6E2B3OriRMz1O6huu9rafo3Z67wnmeS2eVjfXA+6dYcM58n7phGkNC6wn9IFyV0OzC/y33kfFnJ5fY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1130
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

>  	hv_common_cpu_die(cpu);
>=20
> -	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
> -		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
> +	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
> +		union hv_vp_assist_msr_contents msr =3D {0};
> +		if (hv_root_partition) {
> +			/*
> +			 * For Root partition the VP ASSIST page is mapped to
> +			 * hypervisor provided page, and thus, we unmap the
> +			 * page here and nullify it, so that in future we have
> +			 * correct page address mapped in hv_cpu_init.
> +			 */
> +			memunmap(hv_vp_assist_page[cpu]);
> +			hv_vp_assist_page[cpu] =3D NULL;
> +			rdmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);

If the vp assist page was previously enabled for root, it will continue to =
stay enabled
when you 'wrmsr' below. We need to explicitly set the enable bit to 0.

> +		}
> +		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
> +	}

Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF6935FAC7
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Apr 2021 20:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhDNSZz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Apr 2021 14:25:55 -0400
Received: from mail-eopbgr770117.outbound.protection.outlook.com ([40.107.77.117]:50753
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232769AbhDNSZz (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Apr 2021 14:25:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNezjswULNsmCjNKW5zQBKrp21/kdU+QhCbnbYzaATKOzbrKWXSoa7SxeOJ5I0JxwpGgc8fQp/NCtrtHNhi6zdzpoR/Lh9WgNj/KpnNu7W8QymKDVHn3a94vqpYC0UE0jlJAMhSZZjZEqR/LL8EfvtCu1qi/EhsyJiB3wdMFYYG+1h3Y75KTWzAHTAkLZi1vu0H6VKyjfxxNsoSZKHIaM5vR8aS1Li/reLXZj0tzuqXr6tjGY3msxY00RJ99uo+rISNOoY26QW6+6s5Os9iX5VHpo43gFBfU6jCSHa8N/rxB0jdlq6Rweb5qArB8PShiKNN9j3Oz6vZ+zo68gLHcEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ua+nWujKIin8Ejn9PjI5i2L7E4EmtrykpI3bWqb33F4=;
 b=ADN3ETuEhWbCakfCaqVi+LQQlh5rrWxNPCEFY8gqn7zD0OfjUxvCmzkN3e7homIG5BSb1AuhIGNZrnMdmhmgNV6gVrgOigD/nTVm9K8I5dkh8WpvQ122s7Z0goeRQybV9dmwQjR0RZutuayqB1r84f8nD4jkGlThgIKqE+kU7RNl6R7deoU1dQ364uj8tWSnRoiG2bDCvUDXhpe0/lYTihFPCmFog7sSREhiAcBl5PcXF76eN0SpD3Cyo4avVJECmrXLtORcxEs+Z0e/aIdVps2ZekqygNRfGGYDZQL4yvYv1QpE3+FyC0e+jryAtgGLIjlDvF0Q0wjEOMx0lanCvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ua+nWujKIin8Ejn9PjI5i2L7E4EmtrykpI3bWqb33F4=;
 b=N8LTUOfrkI6KJo4zxFSdZLCeEZ0HIsRt+l03Q761Jg7BssLIuyWxy5AHiCrZaCqpA4ChsIUPu4WAKzOUJFQ+LGIC/9nhXzP0+DbVLFL4aIYEFh3lvd4zeDNuG+lLejHNv1qitel88hNpIp64AQjC8cYHZ/KRPa/yb7LGGQny5rw=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1875.namprd21.prod.outlook.com (2603:10b6:303:72::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.1; Wed, 14 Apr
 2021 18:25:26 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f%4]) with mapi id 15.20.4042.017; Wed, 14 Apr 2021
 18:25:26 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] Drivers: hv: vmbus: Introduce and negotiate VMBus
 protocol version 5.3
Thread-Topic: [PATCH v2 1/3] Drivers: hv: vmbus: Introduce and negotiate VMBus
 protocol version 5.3
Thread-Index: AQHXMT8Qklh3Ffatf02JQEd47yxe3aq0VEKA
Date:   Wed, 14 Apr 2021 18:25:26 +0000
Message-ID: <MWHPR21MB15935F8B28EFE3FAB8533F50D74E9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210414150118.2843-1-parri.andrea@gmail.com>
 <20210414150118.2843-2-parri.andrea@gmail.com>
In-Reply-To: <20210414150118.2843-2-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b92541f8-eb9e-40de-9a56-7177db7e74e7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-14T18:24:16Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78937eee-5d1d-4f89-cf1c-08d8ff72ad23
x-ms-traffictypediagnostic: MW4PR21MB1875:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB1875666948A0E9F337DB6092D74E9@MW4PR21MB1875.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XTSBoxGHUcT/RqmurYEsawmcAsgRhBuG8l7vaLsU8V8Xl3WEwbXyqRGfgmtI7I/LiITgmpoYhdFkS/pH1+AISPs6lbgj18XdsoVmiow8KDpa9LHOPXaouLAZ6uqXyozHo7qMrwUZ4QMntXRomzO67wQito1KOY93urOf64DyLIJyIgfQPNgpirnGa9c4qFw0v79L90bwTO6Q0SXTXlL3k4R+ftHrQiW8xbBNpiIsmSWsbnW/xg0FGGgny+GNpYN+fgMA2VNx8HvLET6qUXfVpCkaMoEBW6KYgrR4LN6gN19FmeKoax4X28i85bmf5DrmKcA2CQuUZQJQyMYpLRz534KcVr6ry+3+8QfkbSLHTxehezhCB1TRQW8M4czxu+GAozI7fipm08WHzWqMYqDIxyUBb+GPFjaj4PBUlj6vIL2SGHA3tZXkKM5ndRHjOWRDrNRRpnF+7M7nJu0EUc63AVtZZXbLP7eIbXx1jsT/y2DMVbQzUkJQ4mlJkGssqB/6z2YEnSQv4Vz56C46G9gqUVFe4+D5ntjvPkd1Xi2L9+fYqe0agSodgw2HDaqKFt2/FqePTiaC60Y4xYUh1LxGCrX7zDavUKOUaytz9eRPW6U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(8676002)(8936002)(7696005)(122000001)(10290500003)(9686003)(55016002)(316002)(6506007)(71200400001)(33656002)(86362001)(38100700002)(54906003)(110136005)(5660300002)(478600001)(186003)(66446008)(82960400001)(82950400001)(2906002)(83380400001)(4326008)(76116006)(26005)(66946007)(8990500004)(66556008)(64756008)(52536014)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?A53NuKdes9InH/f0X9v8XTPzZpVT1wfNMWgChxq26mdat5399Sc3LwAPYzSA?=
 =?us-ascii?Q?XrhMkQ7FGguiI7kRnAOHXanhhGzQSAlDccDzCzRqLubhTgcLWcz0wEbHYxah?=
 =?us-ascii?Q?oiwYkK2XXg2QVhBmqOzOyEyJtXAKKMoJH/AZX6xjX8xvV1uKp3+OC4LIPT0d?=
 =?us-ascii?Q?XEiQ3/2CTh/9Y0ZYNNLVn8tSEetcn7YmHGGbjuXARh0q1//7VMZXMQeB3Btx?=
 =?us-ascii?Q?hlTbnAREAtKdLeDdPxnpxTCtnEpMY17nx27FkbA8szS0OWfGYBFD8fU5feIR?=
 =?us-ascii?Q?2y8UH5ta4Vg/swBwcv6uSqUO17ZUhW9IQYB2duJCn0Di7pgYGgGEODJFLBMZ?=
 =?us-ascii?Q?FiANztsH/FbIZ5FYJh82zfv64Q12ImjIDdU12gWQsS/z24kopWZ8Nd7KQQQm?=
 =?us-ascii?Q?a3XFTTcNVTjQpzPE5Fxd/cf1iKFOahdbtMDY1HXymaLa1X6Zv6RGEc6tmRgL?=
 =?us-ascii?Q?wcuZvFohQy4fUzCtyltas7G3Nweh7SEqDC6jNf5E0S72hXJOD4TlWqVB/jUz?=
 =?us-ascii?Q?2JbdNZhLGd0Zvt/wqQDQakL/ztBpbf8f9JFxwP3eAuVEvh/Sj66079ph/WYv?=
 =?us-ascii?Q?8kJNcROlBVOINnYK2TRyEHF464DY5iHoyhFTskqLYBEpQbEaGGo94J0Fp0t/?=
 =?us-ascii?Q?Z8aOXpbYRx/4fWDyek14Z/KtlfXK+F4xKkaQtXHpDRElGG1Ua0Hjnc+JkpW/?=
 =?us-ascii?Q?CuT9w7S7NXzPKh65J5kHShfeveLu91JsF+U7FYNvFb00cpNZ3jUfETFjGCBZ?=
 =?us-ascii?Q?xjrjUbaNIMvquSbaDl5Ncko6sy4idxpKUVHs2yxE5oNh2CpOTOmW98oYEZko?=
 =?us-ascii?Q?N7wY/MZLAqcC7DvZVxgeqalekk2afseWEYAKTErCl8SC5NJd3lkacJSKmxm4?=
 =?us-ascii?Q?sJ0QQuo2WFdpDukJFN5o969bKKTTAdoUuftV/FEsegKNtKGAN+5C4hGafYoR?=
 =?us-ascii?Q?M/ws+/kT4KW3uCyKa4BBDpdMRXbYVjeOS71BHVoj/dzJG0rm5KKS5hyCOHc2?=
 =?us-ascii?Q?u9RRjfyCPJUMU8g5Jo1/4+fQylA1iUqzoOlqS9Zx/nimDD4/9/5tItviGHZm?=
 =?us-ascii?Q?qiDgqTOyHrSdeA3kFYva56knLYBQGwAofjqkykOXfQx+n50njesPLoiAGoRN?=
 =?us-ascii?Q?E4uP6etG2mGnFV4PSUrdTLYgczzRUUIs2DO7XBWCxTgARioZ1K0tCIi6MQAX?=
 =?us-ascii?Q?CuSWL53N8vMN2QKrPI7D08DcPhIXfeuRFH+ZJ+2KnpguwB3piv7jC/ZlAVeJ?=
 =?us-ascii?Q?na8dpKl26OuAIgBvCFqFCzBWN5w+fAX/58efJbFgRryBHH0PIcH0CbKP0i2m?=
 =?us-ascii?Q?liyV7sQnYfMCVzZo2Tln2XAV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78937eee-5d1d-4f89-cf1c-08d8ff72ad23
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 18:25:26.7635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3XX2lZ4bZ1pEecdzu0wRBcIrCQUP1YRN4ByyxEZ9LvaXlf9xvZ04lKSjVOa7awRQCx3j0md3VtKhZnBg6kuSQOW3iDPBtZI11anHcRnI4KM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1875
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Wednesday, Ap=
ril 14, 2021 8:01 AM
>=20
> Hyper-V has added VMBus protocol version 5.3.  Allow Linux guests to
> negotiate the new version on version of Hyper-V that support it.
>=20
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/connection.c | 3 ++-
>  include/linux/hyperv.h  | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 350e8c5cafa8c..dc19d5ae4373c 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -45,6 +45,7 @@ EXPORT_SYMBOL_GPL(vmbus_proto_version);
>   * Table of VMBus versions listed from newest to oldest.
>   */
>  static __u32 vmbus_versions[] =3D {
> +	VERSION_WIN10_V5_3,
>  	VERSION_WIN10_V5_2,
>  	VERSION_WIN10_V5_1,
>  	VERSION_WIN10_V5,
> @@ -60,7 +61,7 @@ static __u32 vmbus_versions[] =3D {
>   * Maximal VMBus protocol version guests can negotiate.  Useful to cap t=
he
>   * VMBus version for testing and debugging purpose.
>   */
> -static uint max_version =3D VERSION_WIN10_V5_2;
> +static uint max_version =3D VERSION_WIN10_V5_3;
>=20
>  module_param(max_version, uint, S_IRUGO);
>  MODULE_PARM_DESC(max_version,
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 2c18c8e768efe..d6a6f76040b5f 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -234,6 +234,7 @@ static inline u32 hv_get_avail_to_write_percent(
>   * 5 . 0  (Newer Windows 10)
>   * 5 . 1  (Windows 10 RS4)
>   * 5 . 2  (Windows Server 2019, RS5)
> + * 5 . 3  (Windows Server 2021) // FIXME: use proper version number/name

The official name is now public information as "Windows Server 2022".

>   */
>=20
>  #define VERSION_WS2008  ((0 << 16) | (13))
> @@ -245,6 +246,7 @@ static inline u32 hv_get_avail_to_write_percent(
>  #define VERSION_WIN10_V5 ((5 << 16) | (0))
>  #define VERSION_WIN10_V5_1 ((5 << 16) | (1))
>  #define VERSION_WIN10_V5_2 ((5 << 16) | (2))
> +#define VERSION_WIN10_V5_3 ((5 << 16) | (3))
>=20
>  /* Make maximum size of pipe payload of 16K */
>  #define MAX_PIPE_DATA_PAYLOAD		(sizeof(u8) * 16384)
> --
> 2.25.1


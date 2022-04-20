Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB51508B1A
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Apr 2022 16:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354380AbiDTOue (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Apr 2022 10:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354361AbiDTOud (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Apr 2022 10:50:33 -0400
X-Greylist: delayed 83419 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Apr 2022 07:47:46 PDT
Received: from na01-obe.outbound.protection.outlook.com (unknown [52.101.56.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1586379;
        Wed, 20 Apr 2022 07:47:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPAlDl2LnSpVbQh2qwZN9agPUppbyyWOkS5Un1eZF8Zsck/kZxQGfLy/DpQDs0c32HSmHm8YPsxxJa7tt0VpauH8d193Tt45PGkL7OR0NQbIvlhWH1HzVkgU7HRSagG7+miiGmI89kI1rX/1eM4Os9wnyW58P9yg2GReWM3I9ZxHM0O1fclD0p2OW+XsjCwAF9CI9wINpwpYzpln6qfv40uVc71SNPMO6AhSmGczcrgjoEHTnIQeBwXKfXku/8BEvaUt4uO0EjiUtBF/JaSfNJ+rgWxZJqz+T8y5kSXu9NArk9Xx2piLTtzLnz7LFayhrSlgPqo7uVgrXNxekpgQdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRnFwSMex6Vzhkc2HFf9zrsiTh24Ja17MmyQ0RDVMz0=;
 b=lnizWqOoB8/Qhb4OTPwoFHF3XalGwWkuWrUye/YwNcxA9PCs0H5r/bdgDHxc7F4D03WUQClp9TP1J3lXjaTHs/TtgWdTb7CsipiPAzbLnGGX9fULFRKA1XpCKUmJ6E1MG0vQP7iv/dbgcCEB9aWYldvh3w/KtHZJZvURX6FQGgEXVZeQ8MF/9ZSeB1+DwMBS978y5C9UpuH5/yOB5nUSeWxP7RJsXlLUv2kan2XUXPHFE27gdQPqYj4ov36Xco2X83W3RjMDJDF/UkVkWfNPMlLvSw6MNwjlyaMdxi2oWXZ9Bx3OvQZ1pex9Q3GGmiyjkMAj8UgD2q12Xh5rmoCnRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRnFwSMex6Vzhkc2HFf9zrsiTh24Ja17MmyQ0RDVMz0=;
 b=Wkmm9h0gnuUl7ZRGQ6l+U7Y8lt5CyUgHYPVXhXv+oTKoCt2nljX851IJTbznzFqU/cE4LaWkQCbct5rvxmfMXgxm3sOaRPChYVR9GkSDDctEnEqtHw9mkkgfgzg6TPalvx1C6KjpDNZH9SCs4Nj+8J9UMBKwR8VRCo0xmDKl2mk=
Received: from BY3PR21MB3033.namprd21.prod.outlook.com (2603:10b6:a03:3b3::5)
 by PH0PR21MB1959.namprd21.prod.outlook.com (2603:10b6:510:1a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.4; Wed, 20 Apr
 2022 14:47:44 +0000
Received: from BY3PR21MB3033.namprd21.prod.outlook.com
 ([fe80::1841:e0b7:8ea2:39ef]) by BY3PR21MB3033.namprd21.prod.outlook.com
 ([fe80::1841:e0b7:8ea2:39ef%7]) with mapi id 15.20.5206.006; Wed, 20 Apr 2022
 14:47:44 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>
CC:     Jake Oshins <jakeo@microsoft.com>
Subject: RE: [PATCH] PCI: hv: Do not set PCI_COMMAND_MEMORY to reduce VM boot
 time
Thread-Topic: [PATCH] PCI: hv: Do not set PCI_COMMAND_MEMORY to reduce VM boot
 time
Thread-Index: AQHYVDjoO3dF7i2ZcUqQCCMnoHqEzKz44nEA
Date:   Wed, 20 Apr 2022 14:47:43 +0000
Message-ID: <BY3PR21MB3033800D4F4A1D0C94B81290D7F59@BY3PR21MB3033.namprd21.prod.outlook.com>
References: <20220419220007.26550-1-decui@microsoft.com>
In-Reply-To: <20220419220007.26550-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=eea7e5e7-f02e-4ada-9c7f-869b9be550c7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-04-20T14:46:40Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7924547a-e0b6-4df3-72a3-08da22dcba30
x-ms-traffictypediagnostic: PH0PR21MB1959:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <PH0PR21MB195963DFEC202684DF1B72ECD7F59@PH0PR21MB1959.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BBdC121hvhJTmPt1kFJYdaaS2Ly9E/T2Q7JfzTb3+ePex5+6rOz4bvjzEdH8lVE5tIS4yvhBIRBI+bNkbIkj/Q+lGJq2Pd0tGy2uP50hVpGRmsQrudlm2GhcMTSX2GxbP9FjT0DkT2pYtuxOHJKH1nK97RSugnLrZTyllWa6oEbozBVjjkIcaNVVR4pndofSn3OoTiglfkiRc3viKonwz/zJEUegA05pmtivuqA+tot5Zf1Y3AcZGcVhvD0PWlNT6rmdxIk7m8sYNP5jZluTIdcFFm8rtKuXBBLfEm4VS+gQ6CHQnFgXymKYpx2/eC+JCClFdNKHIR5ECNsVnoFXIxaie/RTx2x8SuF5sa1S2nkea2FCfjKPHkMxN3PlFQqY8+m0WdGxwHs73oGVfRoirDktziHvaE/9kzZH+WaOK91o8QimbJmAji1scd0fDhmf01GoaQ41q23ZgITzk6Wyfg6zlW7Hc2rustkHlvhhSqdQqSN/zgVTWbIJE9bJvbDDN1OWEoYCgnin8n5M/bX356boQt2ySUplHNENdDKUqn0MZqLaz0DQrc1pA5jNm+ikSIWtDkNo8NGzKePGQd5UL75XlABb1eqrokzHhwuEAgYSSvQ5p/UTt5aWKYqtazi/ZlEk6BN4lgUdag8xVtaXEPQ71stFJZ5WJADLtJKQJJSHatGWoDVC0vllZjskuNh+w9caXOhxXJ6uRFpa80qmcSmHPOaNdzQ4LLJwzaCRZDksOEEeQ+qk+chboOvVllNP2h2mqRiQRP2HELvOaW7MzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR21MB3033.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(4326008)(5660300002)(8936002)(33656002)(52536014)(83380400001)(86362001)(107886003)(71200400001)(8990500004)(26005)(9686003)(6506007)(8676002)(66476007)(66556008)(66946007)(55016003)(110136005)(316002)(64756008)(2906002)(82950400001)(38070700005)(38100700002)(82960400001)(10290500003)(66446008)(508600001)(122000001)(7696005)(76116006)(186003)(921005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WBWBhYHC+rcpA0lybl8K8mInHFgJ5+Nk3615j/hFS0xEiQZHz/wj0E0M0OB4?=
 =?us-ascii?Q?jqwre4NkgRgE8SnuSA5sCDRRUpn9fsDn+liTAVJctIxTQxfnnJFhFpidmH39?=
 =?us-ascii?Q?wd+hXiAR+tzaAeAQ1weOqYl2biA2ssrS0KTr+mAySaOPb28O4oeo0lwRMLyy?=
 =?us-ascii?Q?yr+WVMue7acRr+eIuY+h4oonsHlP7TnLehwzGcLwNScIHKzh02yAS8CnGT3L?=
 =?us-ascii?Q?UJJ41bQ/rhutgfpUM9ipWSaRJEc7UVKhNHxr0/SF3meF51qgEvMS8AN3AwoA?=
 =?us-ascii?Q?3omiLGNpdjAaALeOuXlQ3lRZraW2fJ8yn8SSOnlgDQnV+otg3eMeK+VxhyFR?=
 =?us-ascii?Q?yb/FQTFahLDvdxQJ7OSEVXKUR8oacxki65jOiTCaVJqL8c/j/WBIN/wotrP3?=
 =?us-ascii?Q?IKSWwQp3ihHdvUWufdA+Xj4QN0vLIo5DdBOT/qgkTz8//RklpGPPIO2h6303?=
 =?us-ascii?Q?+LntY0+uzZOGTv4ecrlhq0giQ6dEOijFFAL+wTAriwLdj+EuS1O8daMUChS6?=
 =?us-ascii?Q?tgcCJoiFWsZaQ9r6dhSd63cxsUkw9np4t+2ajPyN98rcsI5BopTMRrnOleRn?=
 =?us-ascii?Q?BK+WI3NU8RXQQj6dTZgo3uwnyjLycWTYgMfWHLcsJ3nDccwVMyUEvK+frBQD?=
 =?us-ascii?Q?RVryAy1sFF6OPMykYjiuRKxDqG+FYk1Q/E0qBtqB2usbDB7ojYCvLJNoi0LX?=
 =?us-ascii?Q?bcyWd4ul/5oPnuztcYswOptE3QBKsju0T+TY5OXCIbzA34gWm+cVZEBoQgLS?=
 =?us-ascii?Q?4xdIZ6K9fa4tfU8iCzS0A04sN0tD+EhgpjsdFbwnBOiPsVd6tCNn8uIXjaBW?=
 =?us-ascii?Q?SuOSA6ZbUaubEnHrAIDAdVtG+nSv65RSAzMxbsil5mHG4vQW9NXvRz4J8GrW?=
 =?us-ascii?Q?+OCY/T1PrY2kWk6Wafa3uxUycuwCDB1qfyuk+MR3rmeiu7VZxIZBlP2FwCZQ?=
 =?us-ascii?Q?o79WiLe9jIPox+8nPNcgZrxgV1vB2vhd2BbXcyN1kaYjW3Yx2wThbxM60CIH?=
 =?us-ascii?Q?LcLx2ARPXvbK1w5dOVSkTNf5+PfXZNxVHQRjb5z/b1mW8tz2oDiQKUpC3HP9?=
 =?us-ascii?Q?NSi2QwImz6vxbBIldRioQRpNs8qE6iuJz4E54/iDfC6e1YdUngYTVq1MaXrX?=
 =?us-ascii?Q?FkxXDiVfPJafAs4n/9Xgbbanc0h4c1q6BzDD4iV4m2RjSG9sjR10AKmBQ6v1?=
 =?us-ascii?Q?2Eo/IRokisvW8ItWaIBTQ3Kd/QfclwN0xV1/g52bqlsaYTOV7RnwULmqEkRo?=
 =?us-ascii?Q?SMKnfA/RNe26PL3binRc8ZNB/0GRkubsX32GjQ/i2hbtb4YUxFL7OjMh2kZb?=
 =?us-ascii?Q?9ul+vUe22GLXAjUV6WhrYwEHzEZeoHXwHHmxZAdaamrFyrdkjYjcZoJ5TJLd?=
 =?us-ascii?Q?B362LZ4ykb4WpF/jSPlro8qkrqLYPxjHQN2U2iSE+q1YOibYR72lMjfN36rP?=
 =?us-ascii?Q?/2qoFn56sMFyUzub5FDQE14bNm9fNcmCZyTMKGv5bcy0XZ9XEi9LFEm3ylXK?=
 =?us-ascii?Q?N+nccSvQrVSRVM0Y+VyzEqypIrEHfSOnH+75PP5QyAR3XeSW39wBiPLWl5h1?=
 =?us-ascii?Q?XpFRAqPA0F6YgCdj+6jpmS8TZOv2l+lkUVHFkxE0KWHYjKWWCTFO5G4mEQ+m?=
 =?us-ascii?Q?jRiuN5o7cdxLGKaGGATS27GH8odhvEB6G2OI9uayDMZMIMCV4F1aqKXBNtZG?=
 =?us-ascii?Q?mHRbOMO670TcK5uWzzmdeipAvQlYEwapi6WKjxeChPwVMNBZdQPy/C1uOi3Z?=
 =?us-ascii?Q?CCE+mv+sdZoW5FkQa14IFiqlh2zEJQg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR21MB3033.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7924547a-e0b6-4df3-72a3-08da22dcba30
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 14:47:43.7783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4TwKDFTjJ1j6aZR68kHVwOb09i8FtmwzgbAS8wisWfE9ZFhOIgQn+xrkd0uO60bPvDFiXqdcG2pg76q3VyirimwN5OR/m3KPhIU4RjfQu/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1959
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Tuesday, April 19, 2022 3:00 P=
M
>=20
> A VM on Azure can have 14 GPUs, and each GPU may have a huge MMIO BAR,
> e.g. 128 GB. Currently the boot time of such a VM can be 4+ minutes, and
> most of the time is used by the host to unmap/map the vBAR from/to pBAR
> when the VM clears and sets the PCI_COMMAND_MEMORY bit: each unmap/map
> operation for a 128GB BAR needs about 1.8 seconds, and the pci-hyperv
> driver and the Linux PCI subsystem flip the PCI_COMMAND_MEMORY bit
> eight times (see pci_setup_device() -> pci_read_bases() and
> pci_std_update_resource()), increasing the boot time by 1.8 * 8 =3D 14.4
> seconds per GPU, i.e. 14.4 * 14 =3D 201.6 seconds in total.
>=20
> Fix the slowness by not turning on the PCI_COMMAND_MEMORY in pci-hyperv.c=
,
> so the bit stays in the off state before the PCI device driver calls
> pci_enable_device(): when the bit is off, pci_read_bases() and
> pci_std_update_resource() don't cause Hyper-V to unmap/map the vBARs.
> With this change, the boot time of such a VM is reduced by
> 1.8 * (8-1) * 14 =3D 176.4 seconds.
>=20
> Tested-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: Jake Oshins <jakeo@microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index d270a204324e..f9fbbd8d94db 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2082,12 +2082,17 @@ static void prepopulate_bars(struct hv_pcibus_dev=
ice
> *hbus)
>  				}
>  			}
>  			if (high_size <=3D 1 && low_size <=3D 1) {
> -				/* Set the memory enable bit. */
> -				_hv_pcifront_read_config(hpdev, PCI_COMMAND, 2,
> -							 &command);
> -				command |=3D PCI_COMMAND_MEMORY;
> -				_hv_pcifront_write_config(hpdev, PCI_COMMAND, 2,
> -							  command);
> +				/*
> +				 * No need to set the PCI_COMMAND_MEMORY bit as
> +				 * the core PCI driver doesn't require the bit
> +				 * to be pre-set. Actually here we intentionally
> +				 * keep the bit off so that the PCI BAR probing
> +				 * in the core PCI driver doesn't cause Hyper-V
> +				 * to unnecessarily unmap/map the virtual BARs
> +				 * from/to the physical BARs multiple times.
> +				 * This reduces the VM boot time significantly
> +				 * if the BAR sizes are huge.
> +				 */
>  				break;
>  			}
>  		}
> --
> 2.17.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>


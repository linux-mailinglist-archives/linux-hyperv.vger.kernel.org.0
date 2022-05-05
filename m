Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A883451CBBD
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 May 2022 23:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354704AbiEEWDN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 May 2022 18:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377701AbiEEWDL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 May 2022 18:03:11 -0400
Received: from na01-obe.outbound.protection.outlook.com (unknown [52.101.57.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C4B5C748;
        Thu,  5 May 2022 14:59:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OX1dTPQ53qWuuaWYKddW9sbWvOSFhWHthNlyLplyPgRDzy56xjxc0ApNA5HEGoN232D7KmqaaH/RVwbrM8WNp2lBYMtw0Ybp49X6AuhVENdBkz233pmLJANMWiwlOJ67a1Abv92NW/fUesQYPtHb6kYjNPx+cU51Qaen8fHq8PlpiaTLMlHvHk8RbnA2l9RjTQ3nDY7CWV1Elk/RofWhM3K/MPmH4N/nIYfASZdkPg6KLp8T09ui4hF4TZPJOHP/PGQVM4vpKIDgLgNdbtOyBK+IF2x5kONyOiUgoMzGo9/nloDNWEtLzkrcLtqFjBXSKr3nIoTsPe0U3NrxyfeOOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dELLyPxn2//DSjO6BgIocsSIlZ1IJSdT2GbqIMY/etM=;
 b=HdcOLg3crhYHxwEl1aEV+67nH/3wSRBHDY2HzDfwpmr0XSOjx85ssbYPzf3KhsgLViPH20yKB1Wq+QofoknNS0HpL8cccJ3uXWvTETrDFJAxIPi0u4epS53r6jhrleEeY61yxDLlqnAG0OW1MHISXZDj06ZylBsWLa5j+KOr+0yGYBAnS//FDQBQD9oICEP4Z8LuwQuFO+dkBO6rN0Pqi/d1VYyz+nn9cEHg0hvChFCudwrmsxtu1mmCGcmrLZRO6FnkXY9RGNAFtLBr/WRQABUSWsfv3GpNXu0uZ6Auux09h/3i85YFzQWVKawnPsyrNkh622XeEQwgshQkOdFUBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dELLyPxn2//DSjO6BgIocsSIlZ1IJSdT2GbqIMY/etM=;
 b=fhbKxKwkZalBOGSSCerYsxKUw3mxdiUHVm7vEFa3KU2tn42kW56KPSgpcQo2f0xmXH2HFVfBNdHEmH30DTUBAi5BLPLbpk9as+5GsBqiKt27XAaa0RKutGWONxuzaWZA0KC02Ijpl+BKFuCebkiofrYYT6QSaGDYylsTieh17D8=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by MW4PR21MB1971.namprd21.prod.outlook.com (2603:10b6:303:7d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.7; Thu, 5 May
 2022 21:59:26 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::dd77:2d4d:329e:87df]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::dd77:2d4d:329e:87df%5]) with mapi id 15.20.5250.008; Thu, 5 May 2022
 21:59:26 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] PCI: hv: Add validation for untrusted Hyper-V values
Thread-Topic: [PATCH 1/2] PCI: hv: Add validation for untrusted Hyper-V values
Thread-Index: AQHYX7Wg8UmVt2le2kWJacJaFOTIa60Q1peQ
Date:   Thu, 5 May 2022 21:59:25 +0000
Message-ID: <PH0PR21MB302509DA8BE0B347E1916F00D7C29@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220504125039.2598-1-parri.andrea@gmail.com>
 <20220504125039.2598-2-parri.andrea@gmail.com>
In-Reply-To: <20220504125039.2598-2-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2965feff-62f2-4531-9cbd-87a88bc3e11c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-05T21:56:42Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec221dd0-0d8f-434d-9047-08da2ee28533
x-ms-traffictypediagnostic: MW4PR21MB1971:EE_
x-microsoft-antispam-prvs: <MW4PR21MB1971F35964D2C01571E0E017D7C29@MW4PR21MB1971.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ECf3bHLdSq37Y/cJHpVgYH8wdYe9UkwgRrzc+avVKsclQJq815IfrbxMh8kBMj97071fCg20iqaNU2jPjwB4k0Tu8q4ZwfiYYpNnMicLRx8Tj4mgCNbXftS+UoBAzicBfGLdD0BmUJFAgPH1Ed0MbkKOEMRzjyIRWlknaltc4bixwzDW74mfl/bd+tQr6M1wwgy8ZKl0sacyx63/1K+uF/I2n7ACmsz2673wytgj8loeCirqBszdBtjFhytcCMGQJRXHpdsLUmYMR/qIE8hqG5/C9J90kcuJ7s5OTdmTVfQc5cYbl9V0FXt/6W09PEq4XeYQ4hLiWXS1X482cyIMEfq75JRIsCFRSXCKscOLmbRYierMnzOlWdRv/AQ5jhny4VBoIXn4oVaFZocPqSbcU4PsRBXu1qRIAsWI/q3C0yLfivpu0raCPtwue8u5Td0K7ug/DyuCCyxSpnY1Nxi59qwx1UofBplG2aY3eYg83dUx0N29bx+fwXyZv+waWgkH4/M8pLkuERlPoEypxCxNhGZyxtMzLmgeWG+NRlaoN73bFzoMoUaZ6ZCLe+9v8ps61vUT8QPznzXzzeY1KUIaL9BsuRHPFKr5lp0nzvzoWVsQlgVUDuFWQceL/aQDibVAS3MJ4U97Zwgz/gpiQRxhT145GsmqIwdW9jM0y0NJgQkryxF/IXqwik9B5iOalmnM67fauT5W2+P2G7t8deycug+hiZdwgLUjzDjwBHVQu4lDoeukVY3PwCMhVRpaQa8+lviWAbqUKGcISpE8PpdnMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(38100700002)(38070700005)(110136005)(9686003)(26005)(2906002)(83380400001)(122000001)(66446008)(64756008)(6506007)(71200400001)(316002)(10290500003)(54906003)(86362001)(186003)(508600001)(8676002)(33656002)(4326008)(66476007)(76116006)(66946007)(66556008)(8936002)(921005)(5660300002)(55016003)(8990500004)(52536014)(82960400001)(82950400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F9GIxD4A2GTjLVu61d7MNNBtaOTpYfZKZbBrwt3lpNZDORq1HG1I62Q8mUyl?=
 =?us-ascii?Q?Cl24IlCtYGhcEcCFFgd8zQRtI4P0YLPRDKfA333SVIK0ye0CSfeYk6xMsZcO?=
 =?us-ascii?Q?Sf+0W4Wdl8xOn3DUu8QkB+m4dFanPLSqgz+QUk0ckKTYkHZnizrc9Irf9kwL?=
 =?us-ascii?Q?bGLXP0xGcuZxjekEnfgpxNxdJiNa4irf1t2IR8it61i7SRXC1lWvuihR6qua?=
 =?us-ascii?Q?OQr9dJR8nlHpX0qwvFU69yQVuJ+uTeIHJtWY8fYJznqUfbt0UxdY88lkCtKS?=
 =?us-ascii?Q?tctvsBiAV/7HvCwAvxy1kkzPuyp9gotV4KKFJO2j3BE/SNRbtjopOiT5TrrH?=
 =?us-ascii?Q?B6L+S/KR0jO2Gjp7cEu2ds5qiZKQ1HVvXKkkETwvT4j0btgRpBpw38zYevwD?=
 =?us-ascii?Q?5LDvl6u9+0Yj/5cnewvKRNq7vlArrUE8VwkpQosXBTOzIUpy/lDGIPaFvLcw?=
 =?us-ascii?Q?Oh0rYDGbci01aT30nxiqO55Rbeq2IEM5E9qdpgJ8u1HGkgO4flprRUe23Tlq?=
 =?us-ascii?Q?yhMBU2d6E1/uTX0wbS2AgP7CM5ZpRnUfXkoqCGhQawd+fdJl1MZ49RH8IpT6?=
 =?us-ascii?Q?mOyQqMgdf7LbFeKK2NlXFUID6aOsDbNOUbnbJ/gFnqS9S3JI5l+Yatn+/bWI?=
 =?us-ascii?Q?rhOPPYsYxcKgx703lSi1qUtj4jDD8gfzWjiJWlGxji1hxRl9dDOfLMrucFEA?=
 =?us-ascii?Q?VUZGEDqC7zPVcj6KPA4HQ9OUjMq3byVLWhpdJHbendpc1KZwRE0HfL3ml15q?=
 =?us-ascii?Q?RTWP5PjHeeNr6n1NOapu/0tCsLgPa4wLSjueOJj0+VErSsaTJh0jJtf4WzX4?=
 =?us-ascii?Q?HoHw+JG1GK5vcRA1tcsnz34UGMQYXQiSi+A7rotx4VFx0hyEyC6ly3oPOKbx?=
 =?us-ascii?Q?scMNzIjH0Qj8cYnSF7VHx9+GGyrFPuT3gyvJbt+Ylu1KSYpU0vgRimsqxkYl?=
 =?us-ascii?Q?arxsJAq7RoCyJv9XRFNvCzOYNyhz+cr7Kqay+C9eFnAp/ivJIGw81INCeg45?=
 =?us-ascii?Q?XHZt1BRVxEcSsvTDKciadDEZ+51VIBYUZncM/WL+SLEJdWSqS1JFbaWfKQK5?=
 =?us-ascii?Q?gRAOer3iu6Q59ctBp/2x7r/lCNL4V9FKdZD7uXWO0t6DXUTMZBQimnzwx9L2?=
 =?us-ascii?Q?FRRiMlgL1mb6j/g5LTgxBZxgepSb8u28APZgW2GutwSAR5G2ixHrRZPP+ywH?=
 =?us-ascii?Q?6aUMKBVoLvgyVmKxqGO8FK6kWtcIf4vAiOUTPqKp2JsQfLdnpLCWl8xR5wpO?=
 =?us-ascii?Q?/k1YYVVeuKj4UE+GxSXjAYR1rfvw/2FjTAXJJzc98GqlGPnr2SYv8f3wWF4C?=
 =?us-ascii?Q?F8nGrjl6bPR3IA8NLy5fIrMwYGb4JlgSu3SUjOqiYCi2tZya+uwMG5BncAan?=
 =?us-ascii?Q?B5qglw0W5PWE2ipepJZmQ/G+IG2v+QP8sRnGV+rjvM6f/vPmLtds6lssgIqX?=
 =?us-ascii?Q?o6cY2awLPnRGKYHeDWmymdZWfHwPxDCcdQZEX1MS8GHFFoQjvHmgDVewdaCB?=
 =?us-ascii?Q?PHVo3yp1BGeRguDESKoutnvcNo+q251ZQD6I8mN3J1OT/+CWjolzc55mkkpc?=
 =?us-ascii?Q?zaDTaBMtIp6ZkYCiuAqMnFN/jBLEayW/Py2oWBY/CIRJshJvF85BQMbW7d/4?=
 =?us-ascii?Q?8hMPtgpJnlLUp77dhHg2VhTqifyv3c5GGIvJ8OhGBTCQKKnWE9yqDguq0yyz?=
 =?us-ascii?Q?rb75Pc5IcsLlXnH7nKYdclT3EIV6Ld7RzLoFgqKl2hsfL22bgVJy6U7wgDyr?=
 =?us-ascii?Q?3MPbA9jYCj/LeQqxh1p/UHhkN1mF+TM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec221dd0-0d8f-434d-9047-08da2ee28533
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 21:59:25.7582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GQ34TtFockEQyDZxt2i2c16m5pTGdRfPDQ9x3v6OKu5IWGp0rcC8J4sgf56pFSkKxCGFwwB/B54ijlTsayIZeOnaxUvV7TC7XUfeK+lAEtc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1971
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Wednesday, Ma=
y 4, 2022 5:51 AM
>=20
> For additional robustness in the face of Hyper-V errors or malicious
> behavior, validate all values that originate from packets that Hyper-V
> has sent to the guest in the host-to-guest ring buffer.  Ensure that
> invalid values cannot cause data being copied out of the bounds of the
> source buffer in hv_pci_onchannelcallback().
>=20
> While at it, remove a redundant validation in hv_pci_generic_compl():
> hv_pci_onchannelcallback() already ensures that all processed incoming
> packets are "at least as large as [in fact larger than] a response".
>=20
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index cf2fe5754fde4..9a3e17b682eb7 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -981,11 +981,7 @@ static void hv_pci_generic_compl(void *context, stru=
ct
> pci_response *resp,
>  {
>  	struct hv_pci_compl *comp_pkt =3D context;
>=20
> -	if (resp_packet_size >=3D offsetofend(struct pci_response, status))
> -		comp_pkt->completion_status =3D resp->status;
> -	else
> -		comp_pkt->completion_status =3D -1;
> -
> +	comp_pkt->completion_status =3D resp->status;
>  	complete(&comp_pkt->host_event);
>  }
>=20
> @@ -1602,8 +1598,13 @@ static void hv_pci_compose_compl(void *context, st=
ruct
> pci_response *resp,
>  	struct pci_create_int_response *int_resp =3D
>  		(struct pci_create_int_response *)resp;
>=20
> +	if (resp_packet_size < sizeof(*int_resp)) {
> +		comp_pkt->comp_pkt.completion_status =3D -1;
> +		goto out;
> +	}
>  	comp_pkt->comp_pkt.completion_status =3D resp->status;
>  	comp_pkt->int_desc =3D int_resp->int_desc;
> +out:
>  	complete(&comp_pkt->comp_pkt.host_event);
>  }
>=20
> @@ -2806,7 +2807,8 @@ static void hv_pci_onchannelcallback(void *context)
>  			case PCI_BUS_RELATIONS:
>=20
>  				bus_rel =3D (struct pci_bus_relations *)buffer;
> -				if (bytes_recvd <
> +				if (bytes_recvd < sizeof(*bus_rel) ||
> +				    bytes_recvd <
>  					struct_size(bus_rel, func,
>  						    bus_rel->device_count)) {
>  					dev_err(&hbus->hdev->device,
> @@ -2820,7 +2822,8 @@ static void hv_pci_onchannelcallback(void *context)
>  			case PCI_BUS_RELATIONS2:
>=20
>  				bus_rel2 =3D (struct pci_bus_relations2 *)buffer;
> -				if (bytes_recvd <
> +				if (bytes_recvd < sizeof(*bus_rel2) ||
> +				    bytes_recvd <
>  					struct_size(bus_rel2, func,
>  						    bus_rel2->device_count)) {
>  					dev_err(&hbus->hdev->device,
> @@ -2834,6 +2837,11 @@ static void hv_pci_onchannelcallback(void *context=
)
>  			case PCI_EJECT:
>=20
>  				dev_message =3D (struct pci_dev_incoming *)buffer;
> +				if (bytes_recvd < sizeof(*dev_message)) {
> +					dev_err(&hbus->hdev->device,
> +						"eject message too small\n");
> +					break;
> +				}
>  				hpdev =3D get_pcichild_wslot(hbus,
>  						      dev_message->wslot.slot);
>  				if (hpdev) {
> @@ -2845,6 +2853,11 @@ static void hv_pci_onchannelcallback(void *context=
)
>  			case PCI_INVALIDATE_BLOCK:
>=20
>  				inval =3D (struct pci_dev_inval_block *)buffer;
> +				if (bytes_recvd < sizeof(*inval)) {
> +					dev_err(&hbus->hdev->device,
> +						"invalidate message too small\n");
> +					break;
> +				}
>  				hpdev =3D get_pcichild_wslot(hbus,
>  							   inval->wslot.slot);
>  				if (hpdev) {
> --
> 2.25.1

I don't see any issues with the code here.  But check the function
q_resource_requirements().  Doesn't it need the same treatment as you've
done above with hv_pci_compose_compl()?   For completeness, the
fix for q_resource_requirements() should be included in this patch as well.

Michael




Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AC66DE26E
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Apr 2023 19:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjDKRYp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 11 Apr 2023 13:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjDKRYo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 11 Apr 2023 13:24:44 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020018.outbound.protection.outlook.com [52.101.56.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A322185;
        Tue, 11 Apr 2023 10:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDxoYlT91PtFCj2CUAOi3OLaXnYw73pEEdLHuczHA1OHoYqAxTW1nhXhgrzlC5KeODCD4fwKAUCXd+3LiGPgqJR45FvEacgjmGZGY9y2R8U+tgcVFVXKr2+wdM8WEralL7sQF1pj6QcDobdjYxElJJf6bqO0CyUcNLrWi7yGBsFwKcuh8kNdvETpORR+Y4c+NiLmzfshtvOiAoWoxB4U+tRSJgAQNnhNDwunvoxoxkJ74+sZ6LFcsOpiu2jrvzq/eyurkzM9LMIa7nxkg0ZVTCK3IUSwZeVorX/smve7dWVLLPcmE2hX37qwtMZqelh7gRwv7lh8b5t1ry0V4YFpOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGaGtrO+AJUkUivFjqH0cx9z2dbhyPwpjxpWQXhdhtQ=;
 b=gzA9CwZ9IKknlJkmHxjM6oNDnPl3wa5ZyT7seboXGDzbZ8fuIlwengpNzPGLXYVrtW22RwH3eldOrOeg9w+Ol/BZ8feCkkw8f4plDSoybF6EyiJkWS82t076rkBMLXl1sh+4DCxsfu6b7329VLhDC8a2QRdnXDd25hMOrwCJngkcmIlxgRmiiXCqtFhMgxGb/rlyyxkpwLPkYryAv8CQFBHkriqf5w/49zibVngGPwur396KSKamOEVZm4tZ1CnzolgoEPfxGOLovkpv+H0BqK7zeYppCjl4hsccKi95avV1tDSraIs7gULEvBTgLtjG6WDwGsbtn74AqEL8PPiJkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGaGtrO+AJUkUivFjqH0cx9z2dbhyPwpjxpWQXhdhtQ=;
 b=E0CHPlSCjAt75YgMlPG1DEKkyDTm88DCBVC3hHf3sD7z4YNBwDcw5MCfuUAGw/z9poVJei5x9YEp+6lxytZE7V5An9l14kl+mlRrUTyFQE2GyfibRN7gtWDLIdaBWU8BWa9I+LWDgkOJH5UqNSlbcyWSWUYFc18yyj5+VXd2Y8o=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DS7PR21MB3774.namprd21.prod.outlook.com (2603:10b6:8:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.3; Tue, 11 Apr
 2023 17:24:31 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6319.003; Tue, 11 Apr 2023
 17:24:31 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: vmbus: Remove the per-CPU post_msg_page
Thread-Topic: [PATCH] Drivers: hv: vmbus: Remove the per-CPU post_msg_page
Thread-Index: AQHZamH+OMIAzgPn90WevDN3vCzdfK8mXs1Q
Date:   Tue, 11 Apr 2023 17:24:31 +0000
Message-ID: <BYAPR21MB16888F6A2FAB4C47B4010DB4D79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230408213441.15472-1-decui@microsoft.com>
In-Reply-To: <20230408213441.15472-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=21396f20-b38e-4dac-8ae2-c074538afeb5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-11T17:19:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DS7PR21MB3774:EE_
x-ms-office365-filtering-correlation-id: 5cec026d-cc8c-4486-d004-08db3ab19c71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 62yZeC74yy1W9O6ybizzDmPFpVmzfXL4Ro+HCyLizrpesHzt5WVjQ3gf/OeGoZuTE3F1ggtW/YIFwHrNDx8zMkaUASXi7rcotrDizPyxEiNucw6rR1ONFB1VSpc5tsihGFD5bbMc/1t6enzzdzEbrF3h7qedkgzfjn08f90qhmRet3hjqcAtqr82sLdDN3iuTFInInr9ITz9DD6q4OUX6UjP5H39mHWLnHneYs2BCq83YgxzMkxeDvQdQlaPfxfjYIhL/5N3xwT14fAlL8P+QCfqp0Y8Eg2ADryg/ZVVbCq98jmTZr3aRzTH7NJzhcCZnToKKnrvS4NBggejtW1kD/4MMSOJEAUuHAsr9MVcIhATyCw/DbLQQag5LEjU5mAvHNlhvIlYf6HKf2xPvAPRQlLccuqLW6wfl/Bhd009DA1VgKxtHzODqMVjldAlE+nmMVNwoud03tg7QWse0sH21vyonccDsoh/bVK4ctvnlb1M0nClupDRI4CMxdwkMfnxwMw0o5QFjYuDvVj+jPo9DNNy9Qvaux4r10kBROxbattV8xBMrjQWwmPv5hVNvJsyE8TlP7Uc+onuO/7IoTSQC6AwoWzrC1nL5Gc6hehEftr/Jtyhqq+nq/8YEB/oD9rgm9lHcJILkA4Cf9GlfBDv5hIlOfgKrBHtRnMgSTVAlcs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(110136005)(8990500004)(478600001)(10290500003)(33656002)(82950400001)(82960400001)(38070700005)(52536014)(5660300002)(8676002)(8936002)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(41300700001)(316002)(786003)(122000001)(2906002)(38100700002)(55016003)(7696005)(26005)(6506007)(9686003)(83380400001)(186003)(86362001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?459S9n3eCscCng3HJcwj82i+w/oR34mmvO08fb+NtkWtirMuJCRNRg7e1EA6?=
 =?us-ascii?Q?dqdxkyo5te78xlU9Vm2NT+a3ek/N/Nov2bwBxmEqfo2ruX49iM5IOCl4pt58?=
 =?us-ascii?Q?dA9rxHC7ldklQfMVNU1dhnQuSXPasWE8bgijE7a0nmAdCji8gNpWQv8zJWKg?=
 =?us-ascii?Q?uSkNMCQfHITYITug1PhNiC+Nvtl83SHDsrPpaNdToEAlSZl6vNpxqEJFUyRD?=
 =?us-ascii?Q?NnJAGtVlGp+SzyiZZA4Rcxuf6TnxbByDfm3KZ7xa7bYb01GaJngE6kq+9ozR?=
 =?us-ascii?Q?xk5a3rhlgzgxMH0ay/5GphG1aIZFNxCIBbgeNH0wkViQe4MyCImHmzOeOLPM?=
 =?us-ascii?Q?6RznpZaVwUvTNSfUa0DcjzJeqZYc8W2ebYTPeb0a8asqCGyLEmKFIRpxykTH?=
 =?us-ascii?Q?BMp+/ILJ1WN+dqhpCvE/6/sja3hSp7JnFkmxjmDSMzUKOpSJVGgCcPFnWnKW?=
 =?us-ascii?Q?wOGXBcx9vFzn34DU8f7JGSDVIkMMI+8w8ba9GeFOf6VRBoJOE7JelQSNLzZw?=
 =?us-ascii?Q?nHePRV6dP/S9niz7KHdU5ghrofCK27ztMCTlVeGaYgFQVKU0weXsinU/vkml?=
 =?us-ascii?Q?1dyAaQ0v+b6zmPv1lOnTzGPPIMSHdqO8oGLLLKjwWvGBcL6CplCjBGXg+tlf?=
 =?us-ascii?Q?KOABfqKS4TZT44cPSJMU1kaANBFU+CnXuukZAA4ul5frcPZKzUs1EwBQp6QS?=
 =?us-ascii?Q?bHh03l6Za8bvUaGd04ITe4IOnZJm1oFnz5WM/tvfZioWa8azXqgAhEyshmC7?=
 =?us-ascii?Q?jQUPHQ2Sc81Uv/i6dJB9lK8sm6FfXW9jY8aQr+UArEig3yRWOfiw19zKG/0m?=
 =?us-ascii?Q?lc7hxV6cU21PZzrWGV7OA6rQT7P0pABuEaQ6DmyvGk9BkP9xL7NQtO7RzbAQ?=
 =?us-ascii?Q?XzT4SosMSuOLwjRHroUmyE9tBsYI8QXM5YU8Ycgb3t89wO1BsZiec0V9TYpz?=
 =?us-ascii?Q?H846YQs0AFnm3IMnuA1QwtbBZGyv/t23x5fXmkoexwIteDUtW2DVeFgfb3uA?=
 =?us-ascii?Q?9kHcT0ZBS1mICD68avEZMRICKaySX/NvbqY65cUe9Yxj5o53kt7FvnQFIqhc?=
 =?us-ascii?Q?WNlDwlv9mvPC6bg0oUWS/plqdZEr01OzwOn9B3la5gB663JFmcm6SFGryJbY?=
 =?us-ascii?Q?GZ4o+tX7AmSYQw9ZsRspeFbiM9TaK4dDssMLdtFFsox7pnSBDAIKCw5yREtA?=
 =?us-ascii?Q?NkdC6+SxM8N/Y1DBsibCtVEjLLTrBu5dOllV2Rf9/o8+13cMTxOiCcMi54WE?=
 =?us-ascii?Q?IYpQCMq94j+zaUudVbvMkOFeIMwWmnL9LX03MdmX1D2IylMkH9jNLd3y+M+I?=
 =?us-ascii?Q?gfALyr+g053TlMrl/9lUpYyVDj2i4FO0S9DzKyzzfd4VCXzE70f/ehC8c+we?=
 =?us-ascii?Q?1gq0cJS6+ErAMGKOOJHyDNXvwf1QGilJSXlZ1Mb/xzXySepJ3RTwhARTNYl/?=
 =?us-ascii?Q?avTP5eBvzHf3gXXNxgLlEWVObaqNqcO0MbJtuGwj3pdzDrdVYnJb5lv5XyTj?=
 =?us-ascii?Q?3pSl/VkP6I9iN6goM/htKfqLkG5wupKe4HEBpj1o8xFJ2qM0BusDH1wmqn+9?=
 =?us-ascii?Q?IS3XPFNBDEkG8rgrlwsha2DO371aDNZgXPFQ6fmC05LwCB0r0Fe6uWiRPaBM?=
 =?us-ascii?Q?mQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cec026d-cc8c-4486-d004-08db3ab19c71
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 17:24:31.1329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rIX1O3tXP3z8l/I+ic3RGYNPwpjKMIJ06Xy/26izUVbdUDZKgVoH1aHY+vpzLM+AiPNggPxn/84K4nPtP3DZX++NnSuw2iGQLuyNIMr+yYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3774
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Saturday, April 8, 2023 2:35 P=
M
>=20
> The post_msg_page was introduced in 2014 in
> commit b29ef3546aec ("Drivers: hv: vmbus: Cleanup hv_post_message()")
>=20
> Commit 68bb7bfb7985 ("X86/Hyper-V: Enable IPI enlightenments") introduced
> the hyperv_pcpu_input_arg in 2018, which can be used in hv_post_message()=
.
>=20
> Remove post_msg_page to simplify the code a little bit.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/hv/hv.c           | 20 +++++---------------
>  drivers/hv/hyperv_vmbus.h |  4 ----
>  2 files changed, 5 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 8b0dd8e5244d7..30bf122a502ae 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -84,14 +84,15 @@ int hv_post_message(union hv_connection_id connection=
_id,
>  		  void *payload, size_t payload_size)
>  {
>  	struct hv_input_post_message *aligned_msg;
> -	struct hv_per_cpu_context *hv_cpu;
> +	unsigned long flags;
>  	u64 status;
>=20
>  	if (payload_size > HV_MESSAGE_PAYLOAD_BYTE_COUNT)
>  		return -EMSGSIZE;
>=20
> -	hv_cpu =3D get_cpu_ptr(hv_context.cpu_context);
> -	aligned_msg =3D hv_cpu->post_msg_page;
> +	local_irq_save(flags);
> +
> +	aligned_msg =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
>  	aligned_msg->connectionid =3D connection_id;
>  	aligned_msg->reserved =3D 0;
>  	aligned_msg->message_type =3D message_type;
> @@ -106,11 +107,7 @@ int hv_post_message(union hv_connection_id connectio=
n_id,
>  		status =3D hv_do_hypercall(HVCALL_POST_MESSAGE,
>  				aligned_msg, NULL);
>=20
> -	/* Preemption must remain disabled until after the hypercall
> -	 * so some other thread can't get scheduled onto this cpu and
> -	 * corrupt the per-cpu post_msg_page
> -	 */
> -	put_cpu_ptr(hv_cpu);
> +	local_irq_restore(flags);
>=20
>  	return hv_result(status);
>  }
> @@ -162,12 +159,6 @@ int hv_synic_alloc(void)
>  				goto err;
>  			}
>  		}
> -
> -		hv_cpu->post_msg_page =3D (void *)get_zeroed_page(GFP_ATOMIC);
> -		if (hv_cpu->post_msg_page =3D=3D NULL) {
> -			pr_err("Unable to allocate post msg page\n");
> -			goto err;
> -		}
>  	}
>=20
>  	return 0;
> @@ -190,7 +181,6 @@ void hv_synic_free(void)
>=20
>  		free_page((unsigned long)hv_cpu->synic_event_page);
>  		free_page((unsigned long)hv_cpu->synic_message_page);
> -		free_page((unsigned long)hv_cpu->post_msg_page);
>  	}
>=20
>  	kfree(hv_context.hv_numa_map);
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index dc673edf053c3..d8322049ecd08 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -122,10 +122,6 @@ enum {
>  struct hv_per_cpu_context {
>  	void *synic_message_page;
>  	void *synic_event_page;
> -	/*
> -	 * buffer to post messages to the host.
> -	 */
> -	void *post_msg_page;
>=20
>  	/*
>  	 * Starting with win8, we can take channel interrupts on any CPU;
> --
> 2.25.1

This looks good.  Glad to have this simplification done!

FWIW, this patch will cause conflicts with your TDX patch series.  If this
patch goes first, then you'll have merge errors with the TDX patches.
If the TDX series goes first, then this patch will have merge errors.  And
per my comments on Patch 5 of your TDX series, eliminating the
post_msg_page will simplify the error cleanup code in hv_synic_alloc().
It seems like making this patch part of the TDX series would be helpful
all around.

Reviewed-by: Michael Kelley

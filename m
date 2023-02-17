Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF50A69A594
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Feb 2023 07:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBQGZd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Feb 2023 01:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBQGZc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Feb 2023 01:25:32 -0500
Received: from BN3PR00CU001-vft-obe.outbound.protection.outlook.com (mail-eastus2azon11020016.outbound.protection.outlook.com [52.101.56.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C445A399;
        Thu, 16 Feb 2023 22:25:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcDKr+R1deDtsW6OhMLr/fVVu+TsKpF8CeQD1AJ9NTlClERjwwlJTk/Anytce7Z0yzwIRZOz8ouvx16ewxP1YNrtQLIC19zutHRzE+GANJjZlp3+R2PphSulHUB6kp/ZPYib+kqlzPfMdGUoa8t4OGX8uLCsymC8+FYtVQq4U7I4HaCd8KBGypbbwcBypAyMMkvGx8LDEhmTHt0CqX6DCjhNGRg5LnJSkCd9ksWoYsgoEQLC/lC8odqWSM/oygX50GTdGywmb1OO+XLoSM7KcAhvNgwJUQNPKpMsW6Ut2L285ys4ZPUIVGSVczx4eRK+SDFKVa/bE/fgoMp/SbVHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNCoMFBkUxn1t2MXrEbh3yPZ5igZPysviEAX/9VQ5eQ=;
 b=csVa4wlZUs4K60peBPFFBep8zGhMcI5VwjB2AaNADDo3yFTF9Ct6mUBU9KS8wW+kPTCVsT5hSPYWMB8hf1Dk0T2YKJhmKuyl+PKGcRFor2Zm4t+o2l75BG5W1Z57/k6I4NrNZnLONKIIN0HrDzzPLFJuXN8oWjAkVP5hk9hFNAJstNgAocnqycL/ESEGt/ulPyGFlxULh8SzMul+6+xq4wCzJVvEze0n8hSnAEzTDKCcx+GqrLWGtNQBYfTlknqSlC4aM0GTO3nNAhYliwHB3usUjmiIfL75TssoW/2h9Lc5b1liHIC6qQ5WonMt7AZGgZLfHiF9GzTisiC6VKqtrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNCoMFBkUxn1t2MXrEbh3yPZ5igZPysviEAX/9VQ5eQ=;
 b=Snof4P3gyxA/p3OUmgq8WXDmjrjtpoF120fjoMUhdIgTKSzXJb3CDvfmfYbjxuBgE1w/y0FgM0dD3VzKQjVqCLG7T0DCgT1cvltmywl2VO00m7IwDK5jY5GTecCDd6Ajo868Zi5uD5pWzdmlX2PYOnAJG8L7187DXF3nnvxvzgk=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by CO1PR21MB1314.namprd21.prod.outlook.com (2603:10b6:303:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.11; Fri, 17 Feb
 2023 06:25:29 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::3747:daf4:7cc9:5ba2]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::3747:daf4:7cc9:5ba2%3]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 06:25:29 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Mohammed Gamal <mgamal@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "xxiong@redhat.com" <xxiong@redhat.com>
Subject: RE: [PATCH v2] Drivers: vmbus: Check for channel allocation before
 looking up relids
Thread-Topic: [PATCH v2] Drivers: vmbus: Check for channel allocation before
 looking up relids
Thread-Index: AQHZQGdq9M/Cyc8biEehOWpQHv+73q7SrIAg
Date:   Fri, 17 Feb 2023 06:25:28 +0000
Message-ID: <SA1PR21MB1335435701EBB35A9DD35892BFA19@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230214112741.133900-1-mgamal@redhat.com>
In-Reply-To: <20230214112741.133900-1-mgamal@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2ba5c6a9-a36e-4720-83cc-a300faeee30f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-17T06:11:21Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|CO1PR21MB1314:EE_
x-ms-office365-filtering-correlation-id: cbba8679-6e5b-4a40-bf15-08db10afc392
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: df+uRlVaWRU/Kpko6FcyYeld0M4Uk12lnEHblwx2cjoHNdbkQbJyhUroR/QhT7mhFcVY50XZXIFcoq9o7s+ViGbfsyuCOhgU3oKZeDyRPC3Ff8sHJ6wa9hR073iXc9t4M9ig8+LQgg8SxSloZKSKBkTVso4hQ/kOF32kIp/5yosAU+VLp0GldxXLNQOZkUE+7rdPxDQ3H9r89AsYCZGQcpDGUIZKClb9ZElxFyxDQG/K0sNTp2DNBFhq8DkiLCnpHys/SE7TvImOcXCY5K4YgDd7Ej4ZmyQ7ItjEoz6g75lCVFs2gtGrv2lLaj4BUyx1yf6QyGVkOuR6czRsX1vMowQqptFsNM/YZtJWl2fGNljvtH96RgvFD9BbLBL/8M6qp2uKV15ctCweHHyfaetW6BGy8ZcWK5y/n+/hf+9B0CJ3j64k/jZPZjYeSomOcDmsp/fUXG/zuvuAbXkJSbogl4DLMNcauMwx2OM54OFFIh9RP5wYw3MJSBdSeJYeatGOviBLu8Fis0khyIRA19mW3Rasx4Ret4yj9gBLQvzI1PE0zqp7Am79h+rl4JZ1CQHlUPloeum1HRQb4t2DzobGf3k6axTDxUQeMG8fzjBcM40S+ghhjXkF4AstbN6eDj788BY4/vDjtD4nqKFFcBk9pu1LUtv7rX1+ajx/YIvzqW0wNyjIOr6BYmUg2Ihtaeh8LTT5uegvLfQeM1YdOdXfYM7QGoZqYcFmzLhoXyLRYbrLdZthrIfusr1SGPyJ0GZ8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199018)(4326008)(41300700001)(82960400001)(82950400001)(8990500004)(55016003)(316002)(86362001)(4744005)(6506007)(38070700005)(10290500003)(8936002)(52536014)(9686003)(26005)(186003)(66446008)(66476007)(66556008)(66946007)(76116006)(64756008)(8676002)(38100700002)(122000001)(83380400001)(33656002)(110136005)(54906003)(2906002)(5660300002)(7696005)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h1QN3ko7sGVhNKtqLr1VfUx21LR4Id6OgO1GfZDIdNRychwMWOeQaBGM1Igw?=
 =?us-ascii?Q?RWJqLeoCkFLFJxegncTyeOvhXPPkZabMcoJaH1PzY039fPdmxLW3YTpimS5T?=
 =?us-ascii?Q?5SZ13OLvKTCze+ZdFyBKjuy3TBAB0BF03QYFhBUOuGB97u2BqihIAQnbb/TK?=
 =?us-ascii?Q?NOhjfMPcbCpubWOOnGxYbKKwYPntDe7k8rgTBumVhqBgicTsC6xq0omT4duh?=
 =?us-ascii?Q?5a7XBpy44whfSPqg3vwWZ/+KR+cs+b/6+p1IDofPUeqj+lATec5Aanaq/zEM?=
 =?us-ascii?Q?EKFWuP3Rm1zMclvWD9FKlpzV+sHNjAboCDATWtTnoaljiDBTTjkgUH7FUHGR?=
 =?us-ascii?Q?nfU3B9M0rRPgEwjymQ5mokK/+lAkUWVMFxI/VVt5NSj3x9zqPfHhPVNBzgN8?=
 =?us-ascii?Q?Ps9M8UuN8c8xY8mh4oRIhIi7MXCMVl1fzRQ0kFpT3zffpU5dtfUWT7iRbD1U?=
 =?us-ascii?Q?xti7+Vkd/kscseTHgh7jtsHlMuIcqhasal50Zzgb40qNNYQfDt5BZ1wjkSkB?=
 =?us-ascii?Q?SUNtiJ5uJ68hBbaWcrTzPoBSGt8yP588Te+FTbsmSrQwabZ7D6N/VaPqmJI8?=
 =?us-ascii?Q?hy25GMEXo5SZ4mRBVCbKN3jHwb4w/dYYsWeL5rbgRezkaTPsXbaVPoeFnO9x?=
 =?us-ascii?Q?gJ3M/aJ4cq3z9kGl+CQ+uxvBGXVD0cU3zN6UYGGc1yFzYxY/CnsymBAAtjAA?=
 =?us-ascii?Q?8xc8ntg1iSR+znw1NkvzkknvgCqby9ViWs3UFWkw4+C4U691B9M/aiBHoRm4?=
 =?us-ascii?Q?DMENfNrK5byf2gqAgObmYDmWuOLsKOJS0errRkTSpIu8I6kmfFQYuv1mDmc2?=
 =?us-ascii?Q?dUla87JKDKMTANim4hyPHXQfP499MT9PpAx4tYTjNmwySh9IaXT1UjL0vAEv?=
 =?us-ascii?Q?VulRT4hSpFbwNFHi7uUTGVYlNhwk8Lozwr2e1L3xuik6rEf4JPpuqDJY+tmL?=
 =?us-ascii?Q?xq4in2+ESsWwbJ4JPhqJQbF8IU9PlWEWP5F27uERsJCZGBc9w+t+yE3+EHCQ?=
 =?us-ascii?Q?4BFloRi6T0pSXx9YHhQ+kWkczib15rn/2oxMwrhB4PohnpaPItrZSWIP6x0P?=
 =?us-ascii?Q?cGRoY/r09wVbf2JtXRUJNMUj8sbkaMyBC7Hh+BVHYZfUUMVm0LGj+Dx70iZD?=
 =?us-ascii?Q?oZ7knVY7+sE7+dIM1uz8Asll7W2gGJwcFmBInPPr1bAoNb1ib6tyxDKUpdGu?=
 =?us-ascii?Q?aDFUtBz3M+iK3LZbfh8l3DFGVwyMqXM4i+MGrzPPYPb/wYX63JlYAASXgvb2?=
 =?us-ascii?Q?dLDXne4C5EnqDcV40riRxl1OILp/4nWaIwhbJmFCOdniQhfZoQwha4db3nKJ?=
 =?us-ascii?Q?7WaFMcXpwVMLcVpdWZ2Y9FhIirsMMqw6EK2t+8WbrvND4mTAN21QD54f01xv?=
 =?us-ascii?Q?xZx3CoRy6jYTRX0N3nnXATL0D3sp1+LTDl4BS8mo6A+uSrr/XGEhY0sIFGgY?=
 =?us-ascii?Q?kHefzJPGjYjuq2JQavMKllrPkOTquqU4yE2wYKeQ60R7x6WY/JlkRZHKyLBV?=
 =?us-ascii?Q?pcYRdNbF4ofVl3KK0AQd/oVqszRIL2bF7HVaEymHK+K0fd+s8Ysfk3Ri5iDU?=
 =?us-ascii?Q?Pwk/DZo/6Z0yCC29fjqd1/3O/3Kjhdexlye7xOLo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbba8679-6e5b-4a40-bf15-08db10afc392
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 06:25:28.9084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 31atEewjt4azlWZgIp9f8CmOXDWJYmHBbYVDMWLz3Wa9GYsEe5QK+1UmS3wzarmjtrBLTEp2NzAmETN+Z8LAMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR21MB1314
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Mohammed Gamal <mgamal@redhat.com>
> Sent: Tuesday, February 14, 2023 3:28 AM
> ...
> So Make relid2channel() check if vmbus channels is allocated first, and i=
f not
> print a warning and return NULL to the caller.
Can we change the above to:

Print a warning and error out in relid2channel() for a channel id that's in=
valid
in the second kernel.
=20
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -409,6 +409,10 @@ void vmbus_disconnect(void)
>   */
>  struct vmbus_channel *relid2channel(u32 relid)
>  {
> +	if (vmbus_connection.channels =3D=3D NULL) {
> +		WARN(1, "Requested relid=3D%u, but channel mapping not
> allocated!\n", relid);

WARN() may be too noisy. I suggest we use pr_warn() instead.

Can we make the line a little shorter:
        pr_warn("relid2channel: invalid channel id %u\n", relid);

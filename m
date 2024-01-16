Return-Path: <linux-hyperv+bounces-1441-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E4882F014
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jan 2024 14:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F30A5B231F5
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jan 2024 13:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663461BDF3;
	Tue, 16 Jan 2024 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v5VsF5tq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5DB1BDE0
	for <linux-hyperv@vger.kernel.org>; Tue, 16 Jan 2024 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvhZhI4QrSstlN4bcOfuGn6dN4sXljfoX3eanHR4CTNhiR4cwN/5Yu1y924/mN6wArzcg5VUtAvpibHzcihfYdqNYZMqkzQ/TB9G4OIcPjT3Qi7YqIMZM0x1sNAMFILQ+eyxGMj00uKx1ejVVEGrOowfXIg4jgqimGOnjFxMn7K4WazG4EcDkD7uh/0bL72TTviVRETNnaMqY4qqB5sq1rApLsP8H2gUY4XFJEnSp/pYtixQdxU1JothnVWrlpC0zmkVkWcKHFmFiRIHWk0lIpAbQhG9/w/Im+8GMeNw7peTcSxHQzeeO8Cfyctgt1zcDrchj5VZJmHk6F1B0tTOzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9hLmlWcjbzRVHptzMKxuknxqEB6YbZZwl624quRaos=;
 b=grCWSO7ZNeuuK7VjTqxyeRB/oTRWBXmEj/3OKqKu/crfv9bOsqjLlaYmjTfNiZSS6/UcIF3kYrboJrY0lg+YuF0Qu8oe0IqNfKYAKYvvaPiAStWaM0WkofgGLZS4QbattVz3O6VDGlBkJ+Go7R8G7CDR//Kp2uFwd1Z1iiXS8d0c+KRYy5/obSHzenbbdHcwur2u+QchZPG2ZHHkYXeCXya+m/n0nFc8L3evRBqk4YhFIrrOWvEtzZvuWsBXdlHpYobKcLos0xbWUfd4D/zzd4Hte6LbOyuAlgr0ZZEpBg+6p4dK07s4uz80Gi6QIre08Nqn9CIdNe70bb/6kOHFGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9hLmlWcjbzRVHptzMKxuknxqEB6YbZZwl624quRaos=;
 b=v5VsF5tqjVIuMP8pFDpCyC2mj5sNYtUAH8v+V/ACiQWEHrYyWsP9qD7QFlmGabDTdfx87GkkCYAMDLT33Bdw7+WSbA4sxZa9cCwMFBld/bY+DsJznJP5xiz/7c3Hs4WSyA2ANW7wOFaM9hzVgzYb9Z6FX/ohxlj78XGk0Sy13fw=
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by PH7PR12MB6465.namprd12.prod.outlook.com (2603:10b6:510:1f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Tue, 16 Jan
 2024 13:58:53 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::2481:719a:5a7a:d6ad]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::2481:719a:5a7a:d6ad%3]) with mapi id 15.20.7181.022; Tue, 16 Jan 2024
 13:58:53 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: Iouri Tarassov <iourit@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH] drivers: hv: dxgkrnl: Allow user to specify CPU VA for
 device allocation
Thread-Topic: [PATCH] drivers: hv: dxgkrnl: Allow user to specify CPU VA for
 device allocation
Thread-Index: AQHaOHfVsT50vEVQWkagDWJ3H6w7ZbDclzyw
Date: Tue, 16 Jan 2024 13:58:53 +0000
Message-ID:
 <MW6PR12MB88989AD3AA576FB36A023C33FB732@MW6PR12MB8898.namprd12.prod.outlook.com>
References: <20231227034950.1975922-1-Lang.Yu@amd.com>
In-Reply-To: <20231227034950.1975922-1-Lang.Yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=c6bfd747-b0bc-46ee-bf3e-a737678e2aa9;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-01-16T13:58:45Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8898:EE_|PH7PR12MB6465:EE_
x-ms-office365-filtering-correlation-id: 2c23b4f5-0a7a-4ee6-8562-08dc169b4661
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Na4hv6xbkdP/gCZG0NC7XDEqT4mJQlFYxm2lo5IjVg4NRYFnKp+xncKoDvSB5UYVHtzrukElLQj27QzaRaBUh6NE32IUIta5+8Eywt+uYqehr+rNviU1X+EMIHRYgpedh1Qd8Q32OExmvzFSfrzvKhni75HjRfJ+E/97gqqbOzpUMb3FD4RvzVWbdcMR6EX8mtfkCZainG01v+Es9YI/2N7bu2mTkJI5gxhzOj+Z5pmLNptpW+ofSPMDiczLQM7hAbXuLz7GrFzi4TWGcBroMjfixwdLbDvtcDUa2bUKgDAFQ53bgI3qteeTYU5JGIOzbh2IvWfMvJDzdHWag2EY5aUZFXyD2u8ejbbLFwC+brH7tC8dT7DHqjC+Ydox5TXA19uW5i/FMLolWkc6U9+VP12KOBoFS9e2KBLsnqqtlNN1Os8d3OPiOZuj4zlYKgbhYlP8szbysJXhsX36AarBCYduEsGab7N+iNB2ptgEDK4Cn408/C5pLUEsXmSXEYa7crHO8LSSCCptRSqsdK1dwi7eD8x+FwdeRSKZorCR6K6P/7pFiwTfnmGdNRcmW/5xbS2BoxweNBfwVVBnhZR4rYS6leJTbVPOmOmZXCLOGVOXZAfeYLRi4UKrmmqvZUbrAkjGzLKyLdA86e+y5seKXQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8898.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(376002)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(5660300002)(2906002)(86362001)(38100700002)(122000001)(9686003)(33656002)(7696005)(83380400001)(6506007)(26005)(8676002)(66946007)(8936002)(41300700001)(64756008)(66446008)(38070700009)(52536014)(478600001)(66556008)(76116006)(66476007)(71200400001)(316002)(55016003)(110136005)(133343001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?T7pNKAq6qQ8WOfgkBgc9KJvYik1aFuFcz5vqBMzojRltgrzNmsqMUI/bERm8?=
 =?us-ascii?Q?icHhWZnVK/OlPjdJAgh1AGkfWh2Ln89MdMqEGiuOw59+35TG/9brZbqrXuTb?=
 =?us-ascii?Q?Tly6mRo6ZzWcdRi92Rap6gILg6GpFm6+arjHFqjpj5w//rsfd+rV9wTW1uHt?=
 =?us-ascii?Q?+UTIgGmxgz80YtOVnuhXY4/FLAeCKMYMq6hERUE1XpOF6n5J8ZF1J9hJyM/I?=
 =?us-ascii?Q?OY0t4I7C81uAKmLN1emfC26QexR7Tc8UJCP91/5wbO+sK0VfeKjJhMedy0TB?=
 =?us-ascii?Q?z9+XoiZXqkULBTerxjWx3VUqfDSdMktoqXudCOMddhcgu8Bpkx6Y5iCofwFy?=
 =?us-ascii?Q?u6E4uIWWEmEv5HJI4yYd8hAOoH+nMDoHlLOCrAhByDH3EhD08eW8+bq14dfG?=
 =?us-ascii?Q?Hf3vTPmjuI9Wzoz+JdmvuXszZUyfaVVghKan0Itu+9NmOFASRJs57lAwE0mA?=
 =?us-ascii?Q?MHapPnIUeUpRjAcP2zyZLy57TYQF25Gwh6G9kc7nJFTJrQKoivtKUIMXDmVn?=
 =?us-ascii?Q?WW2M/ondAPvF7Wse+ibI5Rnppu3DI6pMBMSdH5Ug/8gegnHSjmHk8gQNmPym?=
 =?us-ascii?Q?75WjfeXhCTaMEIzXv/B7lDEvZ5R3KFsjchRoam6HG3mFaGmDaOyFBtaShyvr?=
 =?us-ascii?Q?jifn5N9o5saV735rrL+RpVmouFj2Au3H6SEwuS0RYKD9A6fmsY1PbsfKDpSf?=
 =?us-ascii?Q?I5sOs2E1gJD6957jcrbPPRLF3SfPU5T55OIWA1PoimvHbVBJVVNeIr9eiE0K?=
 =?us-ascii?Q?5VAlz+vZycnq18DGzBtkCTmEQep+IpM8lDNNz8YYZV+QcR6XjKILMTQHV64w?=
 =?us-ascii?Q?xFO1YkBVAiuDBOBQY+v21jNpbAgug5pfKSiXbR+I+qISchnpcVsKsA9x0fgG?=
 =?us-ascii?Q?7ucUYx8Jpv7xNnQHz0G+FuWMqk9c+Wm+SF/mRqFNHEZCm9gOo3WGh8a4BT5r?=
 =?us-ascii?Q?6nhq24JF2UAgt67pMf8QhuCN16v1XsjMSliQ/SgRljcYHm71nReZOL+RrRiM?=
 =?us-ascii?Q?cB+XfEBDfFKyWq18Cn9HQhKBT5CeGdkhxB05wXevK7YPrrh/H/G9kB/omZ/n?=
 =?us-ascii?Q?Cjwrdf7KlyO4nuzlLTn0fB1H/6GGQg/H/3AIGSxNS7UYZf1sJ7jZt8qGD303?=
 =?us-ascii?Q?F5dBX7cVAadF1dNmhm9YQrItA35cfZtfsgl+JdyxOoyTxfJmUr2Da9C2MPju?=
 =?us-ascii?Q?KfGO62oPBLCj08oLKrIZupDLGyyezocadLDc6BxwbXN6doiwEOH0gj+zLf/r?=
 =?us-ascii?Q?vVb4tRy2xU927o0unNc8H5MgsghAPK39rxBraS8WNyFcXUhvxw/AfoOEZSYv?=
 =?us-ascii?Q?tObqg3+wR6bHf05VPE3X0OL4ddsXTp/uVFkC240W8uZSULlj8VlzxqN5NUx9?=
 =?us-ascii?Q?TPLWqMIRcXzCy/1rWfWVUhTOpWvx7UQIYKCfcTiPEttdjV+Zz1z9SNxPIav1?=
 =?us-ascii?Q?MVM8FliahTLS/tM/z4xHOdyEg021dwIsM1/yERbOb4rx4BwKDRxeWbbovbxZ?=
 =?us-ascii?Q?J/IkM809XdzBEGkiNB4vOYhuWIdFo38fLmcbYOz/Jx86rNrwGRX8Dl6D6vgz?=
 =?us-ascii?Q?Klipjpz7WQYlTYgSIy0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c23b4f5-0a7a-4ee6-8562-08dc169b4661
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 13:58:53.5820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ZcpCeqBPUy2epnFFrJvUzp8tlFxQ/iP7HZyykQV/h3OOO9HhwYcvFUdd9gnTQR0RoLEl7rl0TyDpmK88IdBiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6465

[Public]

ping

>-----Original Message-----
>From: Yu, Lang <Lang.Yu@amd.com>
>Sent: Wednesday, December 27, 2023 11:50 AM
>To: Iouri Tarassov <iourit@linux.microsoft.com>
>Cc: linux-hyperv@vger.kernel.org; Yu, Lang <Lang.Yu@amd.com>
>Subject: [PATCH] drivers: hv: dxgkrnl: Allow user to specify CPU VA for de=
vice
>allocation
>
>The movtivation is we want to unify CPU VA and GPU VA.
>
>Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>---
> drivers/hv/dxgkrnl/dxgvmbus.c | 24 ++++++++++++++----------
> 1 file changed, 14 insertions(+), 10 deletions(-)
>
>diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c=
 index
>9320bede3a0a..a4bca27a7cc8 100644
>--- a/drivers/hv/dxgkrnl/dxgvmbus.c
>+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
>@@ -580,7 +580,7 @@ int dxg_unmap_iospace(void *va, u32 size)
>       return 0;
> }
>
>-static u8 *dxg_map_iospace(u64 iospace_address, u32 size,
>+static u8 *dxg_map_iospace(u64 iospace_address, u64 user_va, u32 size,
>                          unsigned long protection, bool cached)  {
>       struct vm_area_struct *vma;
>@@ -594,7 +594,12 @@ static u8 *dxg_map_iospace(u64 iospace_address, u32
>size,
>               return NULL;
>       }
>
>-      va =3D vm_mmap(NULL, 0, size, protection, MAP_SHARED |
>MAP_ANONYMOUS, 0);
>+      if (user_va)
>+              va =3D vm_mmap(untagged_addr(user_va), 0, size, protection,
>+                           MAP_SHARED | MAP_ANONYMOUS | MAP_FIXED, 0);
>+      else
>+              va =3D vm_mmap(NULL, 0, size, protection,
>+                           MAP_SHARED | MAP_ANONYMOUS, 0);
>       if ((long)va <=3D 0) {
>               DXG_ERR("vm_mmap failed %lx %d", va, size);
>               return NULL;
>@@ -789,9 +794,8 @@ int dxgvmb_send_open_sync_object_nt(struct dxgprocess
>*process,
>
>       args->sync_object =3D result.sync_object;
>       if (syncobj->monitored_fence) {
>-              void *va =3D dxg_map_iospace(result.guest_cpu_physical_addr=
ess,
>-                                         PAGE_SIZE, PROT_READ |
>PROT_WRITE,
>-                                         true);
>+              void *va =3D dxg_map_iospace(result.guest_cpu_physical_addr=
ess,
>0,
>+                                         PAGE_SIZE, PROT_READ |
>PROT_WRITE, true);
>               if (va =3D=3D NULL) {
>                       ret =3D -ENOMEM;
>                       goto cleanup;
>@@ -1315,8 +1319,8 @@ int dxgvmb_send_create_paging_queue(struct
>dxgprocess *process,
>       args->paging_queue =3D result.paging_queue;
>       args->sync_object =3D result.sync_object;
>       args->fence_cpu_virtual_address =3D
>-          dxg_map_iospace(result.fence_storage_physical_address, PAGE_SIZ=
E,
>-                          PROT_READ | PROT_WRITE, true);
>+          dxg_map_iospace(result.fence_storage_physical_address, 0,
>+                          PAGE_SIZE, PROT_READ | PROT_WRITE, true);
>       if (args->fence_cpu_virtual_address =3D=3D NULL) {
>               ret =3D -ENOMEM;
>               goto cleanup;
>@@ -2867,7 +2871,7 @@ dxgvmb_send_create_sync_object(struct dxgprocess
>*process,
>       }
>
>       if (syncobj->monitored_fence) {
>-              va =3D dxg_map_iospace(result.fence_storage_address, PAGE_S=
IZE,
>+              va =3D dxg_map_iospace(result.fence_storage_address, 0,
>PAGE_SIZE,
>                                    PROT_READ | PROT_WRITE, true);
>               if (va =3D=3D NULL) {
>                       ret =3D -ENOMEM;
>@@ -3156,7 +3160,7 @@ int dxgvmb_send_lock2(struct dxgprocess *process,
>               } else {
>                       u64 offset =3D (u64)result.cpu_visible_buffer_offse=
t;
>
>-                      args->data =3D dxg_map_iospace(offset,
>+                      args->data =3D dxg_map_iospace(offset, args->data,
>                                       alloc->num_pages << PAGE_SHIFT,
>                                       PROT_READ | PROT_WRITE, alloc-
>>cached);
>                       if (args->data) {
>@@ -3712,7 +3716,7 @@ int dxgvmb_send_create_hwqueue(struct dxgprocess
>*process,
>       }
>
>       hwqueue->progress_fence_mapped_address =3D
>-              dxg_map_iospace((u64)command-
>>hwqueue_progress_fence_cpuva,
>+              dxg_map_iospace((u64)command-
>>hwqueue_progress_fence_cpuva, 0,
>                               PAGE_SIZE, PROT_READ | PROT_WRITE, true);
>       if (hwqueue->progress_fence_mapped_address =3D=3D NULL) {
>               ret =3D -ENOMEM;
>--
>2.25.1



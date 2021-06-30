Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B9E3B80EC
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Jun 2021 12:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhF3Kqi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 30 Jun 2021 06:46:38 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:44796 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhF3Kqi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 30 Jun 2021 06:46:38 -0400
Received: by mail-wr1-f49.google.com with SMTP id u11so2992776wrw.11;
        Wed, 30 Jun 2021 03:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/bJ9mAQYrDoSXVCmRwiqqyM6D6DKwLpDAmVZGqsyNP8=;
        b=mSfum+3Usmu3DYz3G0He6wxlPhSxPcHmTeYdfKQXjpfla6TlRwOgiN+jwRco+9ue0p
         mbuOIds6uQpGnBSNM4FAvA1Z4JktG1/kMmGD9x0u45ly0dejDTvRkvFzQxqKpM136Lwx
         holc5Etrq0YwtmgWtjrFI/2oDcuoKBnUjWy/iOxq4QClG7o1B5/PExrFmJCyoF//bQ4V
         ZzgQvQzSZvrwGQg55lx6TCI9k69cmCbAYn0QmOz22V7VQRx6kP6gnbTjQJTJpn2mEnnl
         8YLcV51U8aJOfwf2tSQ8cTmFfBdGk91CNR3qt5o9MMzEHIVN9txcs6FskHqd/wBEbD93
         Mh4w==
X-Gm-Message-State: AOAM531XiQuL1asjHJaCujAYiBNI//vsCegn2e/thlRSEoOmv2+UXEu/
        eRitlI7+1xDeKZYN+NliEEhI9FMgYRg=
X-Google-Smtp-Source: ABdhPJyL+mp3g1Emvl7mP2Zj7s2nSsV7cz3X6/FBrJRGHOsgWS6u4mIbcuMgQDH2qB2m4YdGKs5AYg==
X-Received: by 2002:a5d:6d8b:: with SMTP id l11mr38553508wrs.21.1625049848038;
        Wed, 30 Jun 2021 03:44:08 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r2sm21581269wrv.39.2021.06.30.03.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 03:44:07 -0700 (PDT)
Date:   Wed, 30 Jun 2021 10:44:05 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vineeth Pillai <viremana@linux.microsoft.com>
Cc:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 06/17] mshv: SynIC port and connection hypercalls
Message-ID: <20210630104405.3ufcmg5gnwu2hxxo@liuwe-devbox-debian-v2>
References: <cover.1622654100.git.viremana@linux.microsoft.com>
 <3125953aae8e7950a6da4c311ef163b79d6fb6b3.1622654100.git.viremana@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3125953aae8e7950a6da4c311ef163b79d6fb6b3.1622654100.git.viremana@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jun 02, 2021 at 05:20:51PM +0000, Vineeth Pillai wrote:
[...]
> +int
> +hv_call_notify_port_ring_empty(u32 sint_index)
> +{
> +	union hv_notify_port_ring_empty input = { 0 };
> +	unsigned long flags;
> +	int status;
> +
> +	local_irq_save(flags);
> +	input.sint_index = sint_index;
> +	status = hv_do_fast_hypercall8(HVCALL_NOTIFY_PORT_RING_EMPTY,
> +					input.as_uint64) &
> +			HV_HYPERCALL_RESULT_MASK;
> +	local_irq_restore(flags);
> +
> +	if (status != HV_STATUS_SUCCESS) {
> +		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
> +		return -hv_status_to_errno(status);
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
> index 037291a0ad45..e16818e977b9 100644
> --- a/drivers/hv/mshv.h
> +++ b/drivers/hv/mshv.h
> @@ -117,4 +117,16 @@ int hv_call_translate_virtual_address(
>  		u64 *gpa,
>  		union hv_translate_gva_result *result);
>  
> +int hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
> +			u64 connection_partition_id, struct hv_port_info *port_info,
> +			u8 port_vtl, u8 min_connection_vtl, int node);
> +int hv_call_delete_port(u64 port_partition_id, union hv_port_id port_id);
> +int hv_call_connect_port(u64 port_partition_id, union hv_port_id port_id,
> +			 u64 connection_partition_id,
> +			 union hv_connection_id connection_id,
> +			 struct hv_connection_info *connection_info,
> +			 u8 connection_vtl, int node);
> +int hv_call_disconnect_port(u64 connection_partition_id,
> +			    union hv_connection_id connection_id);
> +int hv_call_notify_port_ring_empty(u32 sint_index);
>  #endif /* _MSHV_H */
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index f70391a3320f..42e0237b0da8 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -159,6 +159,8 @@ struct ms_hyperv_tsc_page {
>  #define HVCALL_GET_VP_REGISTERS			0x0050
>  #define HVCALL_SET_VP_REGISTERS			0x0051
>  #define HVCALL_TRANSLATE_VIRTUAL_ADDRESS	0x0052
> +#define HVCALL_DELETE_PORT			0x0058
> +#define HVCALL_DISCONNECT_PORT			0x005b
>  #define HVCALL_POST_MESSAGE			0x005c
>  #define HVCALL_SIGNAL_EVENT			0x005d
>  #define HVCALL_POST_DEBUG_DATA			0x0069
> @@ -168,7 +170,10 @@ struct ms_hyperv_tsc_page {
>  #define HVCALL_MAP_DEVICE_INTERRUPT		0x007c
>  #define HVCALL_UNMAP_DEVICE_INTERRUPT		0x007d
>  #define HVCALL_RETARGET_INTERRUPT		0x007e
> +#define HVCALL_NOTIFY_PORT_RING_EMPTY		0x008b
>  #define HVCALL_ASSERT_VIRTUAL_INTERRUPT		0x0094
> +#define HVCALL_CREATE_PORT			0x0095
> +#define HVCALL_CONNECT_PORT			0x0096
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
>  #define HVCALL_MAP_VP_STATE_PAGE			0x00e1
> @@ -949,4 +954,54 @@ struct hv_translate_virtual_address_out {
>  	u64 gpa_page;
>  } __packed;
>  
> +struct hv_create_port {
> +	u64 port_partition_id;
> +	union hv_port_id port_id;
> +	u8 port_vtl;
> +	u8 min_connection_vtl;
> +	u16 padding;
> +	u64 connection_partition_id;
> +	struct hv_port_info port_info;
> +	union hv_proximity_domain_info proximity_domain_info;
> +} __packed;
> +
> +union hv_delete_port {
> +	u64 as_uint64[2];
> +	struct {
> +		u64 port_partition_id;
> +		union hv_port_id port_id;
> +		u32 reserved;
> +	} __packed;
> +};
> +
> +union hv_notify_port_ring_empty {
> +	u64 as_uint64;
> +	struct {
> +		u32 sint_index;
> +		u32 reserved;
> +	} __packed;
> +};
> +
> +struct hv_connect_port {
> +	u64 connection_partition_id;
> +	union hv_connection_id connection_id;
> +	u8 connection_vtl;
> +	u8 rsvdz0;
> +	u16 rsvdz1;
> +	u64 port_partition_id;
> +	union hv_port_id port_id;
> +	u32 reserved2;
> +	struct hv_connection_info connection_info;
> +	union hv_proximity_domain_info proximity_domain_info;
> +} __packed;
> +
> +union hv_disconnect_port {
> +	u64 as_uint64[2];
> +	struct {
> +		u64 connection_partition_id;
> +		union hv_connection_id connection_id;
> +		u32 is_doorbell: 1;
> +		u32 reserved: 31;
> +	} __packed;
> +};
>  #endif
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 2e859d2f9609..76ff26579622 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -750,15 +750,6 @@ struct vmbus_close_msg {
>  	struct vmbus_channel_close_channel msg;
>  };
>  
> -/* Define connection identifier type. */
> -union hv_connection_id {
> -	u32 asu32;
> -	struct {
> -		u32 id:24;
> -		u32 reserved:8;
> -	} u;
> -};
> -
>  enum vmbus_device_type {
>  	HV_IDE = 0,
>  	HV_SCSI,
> diff --git a/include/uapi/asm-generic/hyperv-tlfs.h b/include/uapi/asm-generic/hyperv-tlfs.h
> index 388c4eb29212..2031115c6cce 100644
> --- a/include/uapi/asm-generic/hyperv-tlfs.h
> +++ b/include/uapi/asm-generic/hyperv-tlfs.h
> @@ -53,6 +53,25 @@ union hv_message_flags {
>  	} __packed;
>  };
>  
> +enum hv_port_type {
> +	HV_PORT_TYPE_MESSAGE = 1,
> +	HV_PORT_TYPE_EVENT   = 2,
> +	HV_PORT_TYPE_MONITOR = 3,
> +	HV_PORT_TYPE_DOORBELL = 4	// Root Partition only
> +};
> +
> +
> +/*
> + * Doorbell connection_info flags.
> + */
> +#define HV_DOORBELL_FLAG_TRIGGER_SIZE_MASK  0x00000007
> +#define HV_DOORBELL_FLAG_TRIGGER_SIZE_ANY   0x00000000
> +#define HV_DOORBELL_FLAG_TRIGGER_SIZE_BYTE  0x00000001
> +#define HV_DOORBELL_FLAG_TRIGGER_SIZE_WORD  0x00000002
> +#define HV_DOORBELL_FLAG_TRIGGER_SIZE_DWORD 0x00000003
> +#define HV_DOORBELL_FLAG_TRIGGER_SIZE_QWORD 0x00000004
> +#define HV_DOORBELL_FLAG_TRIGGER_ANY_VALUE  0x80000000
> +
>  /* Define port identifier type. */
>  union hv_port_id {
>  	__u32 asu32;
> @@ -62,6 +81,63 @@ union hv_port_id {
>  	} __packed u;
>  };
>  
> +struct hv_port_info {
> +	enum hv_port_type port_type;

Can you please replace the enum from the input / output structures with
__u32? I don't think the C standard specifies the exact size of enum so
this is prone to error. You can see in other places in this header when
we need to store an enum we use __u32.

Wei.

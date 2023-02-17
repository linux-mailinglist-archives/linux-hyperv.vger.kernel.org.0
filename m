Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F7C69A89B
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Feb 2023 10:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjBQJwf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Feb 2023 04:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjBQJwc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Feb 2023 04:52:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA325ECBB
        for <linux-hyperv@vger.kernel.org>; Fri, 17 Feb 2023 01:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676627504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o1+rta+3NkuckqAjWQM6EtNRX5v15S6OQpU67+mVbvk=;
        b=M+nvXGiDcpWmK8vZt5KiRXO20KXejOr8ZlSiX1QzZ6vkx80NZOFAm2hVGKnUyq2N6y+oGO
        ArN4lOP9VYsZzR6u6KNHzVn57Xya7zWLspBa/dth7ZHiRcqGCpawbOKOWGFtHxAfvPqu0x
        aRNSPBRN8QHjtY+ESZLDpVvyqb3UHog=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-413-eegZfUyfP6eLYUMD3CE2Hg-1; Fri, 17 Feb 2023 04:51:42 -0500
X-MC-Unique: eegZfUyfP6eLYUMD3CE2Hg-1
Received: by mail-ed1-f72.google.com with SMTP id bd13-20020a056402206d00b004acd97105ffso1293257edb.19
        for <linux-hyperv@vger.kernel.org>; Fri, 17 Feb 2023 01:51:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o1+rta+3NkuckqAjWQM6EtNRX5v15S6OQpU67+mVbvk=;
        b=X1kTDWr1zdw6ctv89ZDEEJ2TuHiYTcJokXBkR/NSShZx7+wVENnXNgh+XPAuJVbNsf
         5riz3OS4O2TFaUgicXRZcvhI0fJJ3ttUHpdY5tAmI7+45OOetVj86AUNGy3xTDoTKvst
         vpWhNhdXJl9uKDsC6y/zc8WmZUnAosBss5J8IUENC60a3luXiEEaYZDgDyxMiajGwrMz
         GMyrxiPHJ7xu8DyZRUJ/6s4SxYImVYtAoHBuniYJB8FeHwta3BBUjqcS8rxNyHKDzCzm
         MOVKX5ngGaSGQ7UIg6ZPjOBDQWRhJ3464ahWrf+8PVo55xkyh7m/Q6UI5MGXqeVmI/aF
         aErA==
X-Gm-Message-State: AO0yUKXqxp/WUK1TWyqwg0ykR7R5KqXyVE7vW/D1yLz75BVHPW5irwhW
        5YupvZ0gxvZQ9MtTofhhfe5FI5vnzEA7ufiA7d1IKkm+zSTnzbgxmFZSzxdzN+fQpmhBMVe+9JQ
        aWzTZrHddoF2MTmuWrWQRLJ9g
X-Received: by 2002:a17:906:850e:b0:8b1:2823:cec6 with SMTP id i14-20020a170906850e00b008b12823cec6mr9378465ejx.43.1676627501180;
        Fri, 17 Feb 2023 01:51:41 -0800 (PST)
X-Google-Smtp-Source: AK7set+MtciHgZrpatIIPvmpLKo9ChNsjgvQkENx4R4w5jnqNoXpHLibqg/87fSITJw9CBbEHdTJfg==
X-Received: by 2002:a17:906:850e:b0:8b1:2823:cec6 with SMTP id i14-20020a170906850e00b008b12823cec6mr9378452ejx.43.1676627500901;
        Fri, 17 Feb 2023 01:51:40 -0800 (PST)
Received: from ovpn-192-159.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id bk26-20020a170906b0da00b0089d5aaf85besm1920132ejb.219.2023.02.17.01.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 01:51:40 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>,
        Mohammed Gamal <mgamal@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "xxiong@redhat.com" <xxiong@redhat.com>
Subject: RE: [PATCH v2] Drivers: vmbus: Check for channel allocation before
 looking up relids
In-Reply-To: <SA1PR21MB1335435701EBB35A9DD35892BFA19@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230214112741.133900-1-mgamal@redhat.com>
 <SA1PR21MB1335435701EBB35A9DD35892BFA19@SA1PR21MB1335.namprd21.prod.outlook.com>
Date:   Fri, 17 Feb 2023 10:51:39 +0100
Message-ID: <87a61cpql0.fsf@ovpn-192-159.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Dexuan Cui <decui@microsoft.com> writes:

>> From: Mohammed Gamal <mgamal@redhat.com>
>> Sent: Tuesday, February 14, 2023 3:28 AM
>> ...
>> So Make relid2channel() check if vmbus channels is allocated first, and if not
>> print a warning and return NULL to the caller.
> Can we change the above to:
>
> Print a warning and error out in relid2channel() for a channel id that's invalid
> in the second kernel.
>  
>> --- a/drivers/hv/connection.c
>> +++ b/drivers/hv/connection.c
>> @@ -409,6 +409,10 @@ void vmbus_disconnect(void)
>>   */
>>  struct vmbus_channel *relid2channel(u32 relid)
>>  {
>> +	if (vmbus_connection.channels == NULL) {
>> +		WARN(1, "Requested relid=%u, but channel mapping not
>> allocated!\n", relid);
>
> WARN() may be too noisy. I suggest we use pr_warn() instead.
>
> Can we make the line a little shorter:
>         pr_warn("relid2channel: invalid channel id %u\n", relid);
>

I'd even suggest to make it pr_warn_once() to be
safe. In theory, vmbus_chan_sched() call site looks like it can create a
lot of noise.

-- 
Vitaly


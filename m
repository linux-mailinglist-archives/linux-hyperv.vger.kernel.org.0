Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91B44CAA29
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Mar 2022 17:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241940AbiCBQ3z (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Mar 2022 11:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241784AbiCBQ3y (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Mar 2022 11:29:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFA6F42486
        for <linux-hyperv@vger.kernel.org>; Wed,  2 Mar 2022 08:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646238549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4JYBVP71dm6qwHu1wwd1S6iPhE9b42/h7o81Qtmexmg=;
        b=YX40hjXQQxCKpwxmYcSumGmf2tAocVIp+/c5FmiSv4UWOuLteu2kPCWnQS8pHZFPrRO+cX
        alNpmMPES3Sb7FW+bmT33i0EKjSVezEr0WCsXxXyMsMIETffdUM57N1TDvYKvJU3NfEitj
        sbku/SlfnJ/q0MM3MpjU1dh7ZdnH6uc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-MgNYZnGEOmeXpFr5MNnkxQ-1; Wed, 02 Mar 2022 11:29:08 -0500
X-MC-Unique: MgNYZnGEOmeXpFr5MNnkxQ-1
Received: by mail-wm1-f69.google.com with SMTP id a26-20020a7bc1da000000b003857205ec7cso554435wmj.2
        for <linux-hyperv@vger.kernel.org>; Wed, 02 Mar 2022 08:29:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4JYBVP71dm6qwHu1wwd1S6iPhE9b42/h7o81Qtmexmg=;
        b=MEEm0NFLz4FCJpw+fqitvhp+NiIY5Uq5P4ApppIWBNISCVzOO+GPfROgR9dpL8z5oh
         GXOxOPDGOntBk9DrUoX6LAAqBFcsN5c+8nM4LLURrKwPun0UNRPWTSk8wNoxrvCmhxWT
         ogFRkNInQaBuea/mKbeoa5GAt7NzO2vMNJh1LCOs2QhNFTLpoUJdMFB50pV0+btptdWB
         ND+synBqxNWg4sMg+q+CetBmDP7epbkndbC9RK4DSh0XjdJIrbLjn+QhBkUDqGKyW+Vh
         D5X8Y6AKf+JKZskXWj8rQmlVH3or1mptn80qL0q6FjSUWxGJi45jkvAl13PiAU1BUchK
         tpuA==
X-Gm-Message-State: AOAM530mD8W2H6TvZRtHvs3tDMlTcRtF6RNUExCmb60rfAjENA4vF7y6
        z68JzUOd7WktpEUfJ0eCfcK8g4Naz4VdSympOfXxaSkSiK7eh1O2Qkyx6S6pyPVBgqoMXgfMsNN
        T3wuaY/JN8yZ42kbc7rv61wCd
X-Received: by 2002:a5d:56cd:0:b0:1ee:3248:525b with SMTP id m13-20020a5d56cd000000b001ee3248525bmr21677347wrw.124.1646238546598;
        Wed, 02 Mar 2022 08:29:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwnuzpoqkxUXsedIQ3mO7DVJwgzjOmZC8iKKjQtEy+lCllqu+K+PPeU8AEGxPiyGzG6Giw9Sw==
X-Received: by 2002:a5d:56cd:0:b0:1ee:3248:525b with SMTP id m13-20020a5d56cd000000b001ee3248525bmr21677329wrw.124.1646238546364;
        Wed, 02 Mar 2022 08:29:06 -0800 (PST)
Received: from redhat.com ([2a10:8006:355c:0:48d6:b937:2fb9:b7de])
        by smtp.gmail.com with ESMTPSA id m18-20020a5d56d2000000b001edc00dbeeasm16594955wrw.69.2022.03.02.08.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 08:29:05 -0800 (PST)
Date:   Wed, 2 Mar 2022 11:29:02 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Laszlo Ersek <lersek@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        linux-hyperv@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        adrian@parity.io,
        Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: propagating vmgenid outward and upward
Message-ID: <20220302112258-mutt-send-email-mst@kernel.org>
References: <20220301121419-mutt-send-email-mst@kernel.org>
 <CAHmME9qieLUDVoPYZPo=N8NCL1T-RzQ4p7kCFv3PKFUkhWZPsw@mail.gmail.com>
 <20220302031738-mutt-send-email-mst@kernel.org>
 <CAHmME9pf-bjnZuweoLqoFEmPy1OK7ogEgGEAva1T8uVTufhCuw@mail.gmail.com>
 <20220302074503-mutt-send-email-mst@kernel.org>
 <Yh93UZMQSYCe2LQ7@zx2c4.com>
 <20220302092149-mutt-send-email-mst@kernel.org>
 <CAHmME9rf7hQP78kReP2diWNeX=obPem=f8R-dC7Wkpic2xmffg@mail.gmail.com>
 <20220302101602-mutt-send-email-mst@kernel.org>
 <Yh+PET49oHNpxn+H@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh+PET49oHNpxn+H@zx2c4.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Mar 02, 2022 at 04:36:49PM +0100, Jason A. Donenfeld wrote:
> Hi Michael,
> 
> On Wed, Mar 02, 2022 at 10:20:25AM -0500, Michael S. Tsirkin wrote:
> > So writing some code:
> > 
> > 1:
> > 	put plaintext in a buffer
> > 	put a key in a buffer
> > 	put the nonce for that encryption in a buffer
> > 
> > 	if vm gen id != stored vm gen id
> > 		stored vm gen id = vm gen id
> > 		goto 1
> > 
> > I think this is race free, but I don't see why does it matter whether we
> > read gen id atomically or not.
> 
> Because that 16 byte read of vmgenid is not atomic. Let's say you read
> the first 8 bytes, and then the VM is forked. In the forked VM, the next
> 8 bytes are the same as last time, but the first 8 bytes, which you
> already read, have changed. In that case, your != becomes a ==, and the
> test fails.
> 
> This is one of those fundamental things of "unique ID" vs "generation
> counter word".
> 
> Anyway, per your request in your last email, I wrote some code for this,
> which may or may not be totally broken, and only works on 64-bit x86,
> which is really the best possible case in terms of performance. And even
> so, it's not great.
> 
> Jason
> 
> --------8<------------------------
> 
> diff --git a/drivers/net/wireguard/noise.c b/drivers/net/wireguard/noise.c
> index 720952b92e78..250b8973007d 100644
> --- a/drivers/net/wireguard/noise.c
> +++ b/drivers/net/wireguard/noise.c
> @@ -106,6 +106,7 @@ static struct noise_keypair *keypair_create(struct wg_peer *peer)
>  	keypair->entry.type = INDEX_HASHTABLE_KEYPAIR;
>  	keypair->entry.peer = peer;
>  	kref_init(&keypair->refcount);
> +	keypair->vmgenid = vmgenid_read_atomic();
>  	return keypair;
>  }
> 
> diff --git a/drivers/net/wireguard/noise.h b/drivers/net/wireguard/noise.h
> index c527253dba80..0add240a14a0 100644
> --- a/drivers/net/wireguard/noise.h
> +++ b/drivers/net/wireguard/noise.h
> @@ -27,10 +27,13 @@ struct noise_symmetric_key {
>  	bool is_valid;
>  };
> 
> +extern __uint128_t vmgenid_read_atomic(void);
> +
>  struct noise_keypair {
>  	struct index_hashtable_entry entry;
>  	struct noise_symmetric_key sending;
>  	atomic64_t sending_counter;
> +	__uint128_t vmgenid;
>  	struct noise_symmetric_key receiving;
>  	struct noise_replay_counter receiving_counter;
>  	__le32 remote_index;
> diff --git a/drivers/net/wireguard/send.c b/drivers/net/wireguard/send.c
> index 5368f7c35b4b..40d016be59e3 100644
> --- a/drivers/net/wireguard/send.c
> +++ b/drivers/net/wireguard/send.c
> @@ -381,6 +381,9 @@ void wg_packet_send_staged_packets(struct wg_peer *peer)
>  			goto out_invalid;
>  	}
> 
> +	if (keypair->vmgenid != vmgenid_read_atomic())
> +		goto out_invalid;
> +
>  	packets.prev->next = NULL;
>  	wg_peer_get(keypair->entry.peer);
>  	PACKET_CB(packets.next)->keypair = keypair;

I don't think we care about an atomic read here.  All data is in buffer
by this point, if it did not fork before that then we are ok, even
if it forks during the read.

We probably do need a memory barrier to make sure all writes complete
before the read of vmgenid, I'm not sure which kind - I think hypervisor
can be trusted to do a full CPU barrier on fork so probably just a
compiler barrier.

> diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
> index 0ae1a39f2e28..c122fae1d494 100644
> --- a/drivers/virt/vmgenid.c
> +++ b/drivers/virt/vmgenid.c
> @@ -21,6 +21,21 @@ struct vmgenid_state {
>  	u8 this_id[VMGENID_SIZE];
>  };
> 
> +static __uint128_t *val;
> +
> +__uint128_t vmgenid_read_atomic(void)
> +{
> +	__uint128_t ret = 0;
> +	if (!val)
> +		return 0;
> +	asm volatile("lock cmpxchg16b %1"
> +		     : "+A"(ret)
> +		     : "m"(*val), "b"(0), "c"(0)
> +		     : "cc");
> +	return ret;
> +}
> +EXPORT_SYMBOL(vmgenid_read_atomic);
> +
>  static int vmgenid_add(struct acpi_device *device)
>  {
>  	struct acpi_buffer parsed = { ACPI_ALLOCATE_BUFFER };
> @@ -50,6 +65,7 @@ static int vmgenid_add(struct acpi_device *device)
>  	phys_addr = (obj->package.elements[0].integer.value << 0) |
>  		    (obj->package.elements[1].integer.value << 32);
>  	state->next_id = devm_memremap(&device->dev, phys_addr, VMGENID_SIZE, MEMREMAP_WB);
> +	val = (__uint128_t *)state->next_id;
>  	if (IS_ERR(state->next_id)) {
>  		ret = PTR_ERR(state->next_id);
>  		goto out;


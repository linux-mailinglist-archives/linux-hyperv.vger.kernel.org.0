Return-Path: <linux-hyperv+bounces-5935-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DA1ADD030
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jun 2025 16:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4753B440B
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jun 2025 14:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9011F194124;
	Tue, 17 Jun 2025 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dd0L0RU9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B459E1FDA7B
	for <linux-hyperv@vger.kernel.org>; Tue, 17 Jun 2025 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171177; cv=none; b=qUFx3A1oVSFziW6qGYgQg9gwfqx6cys138evHXFBkkWrvrxGsVBMtGQCBcrJ+kaKYXOzdoQ7heb172lUM8TDdaQtHUGE4zvKxd4Qljma47zFtRPl8/ejpkqj43S47KbEHhlhpVZjZd2H7W4DSGkympTwVMOw548xKyQ1ld0gouE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171177; c=relaxed/simple;
	bh=P0TmBh/SuinKvkwSU9wHk7cmF2i1xnwgWli/nKJV0Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zx87SdYfa8eUi2jKl/gdhzXH39tHckoafc/FT5I/ruN5v5y6MTy5sd2OpVGeKtd3+uJwCIdOyjMcxnXXQdfNrRVj7kei3o5TkaTz+FHZL0YgamrM5O0CjycyXOUrwRIgaB9gScYDyPZukapPFjxTJkdfN/CRf2jVpmVICtmTVys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dd0L0RU9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750171174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iPUJBR9Qf9kVxYZQYZ6+G9JwWB7GoNLWWQDEXWeJq2c=;
	b=Dd0L0RU9WSfnIGyKWY/8gz92slapCugP0zHXjwsN+Gpg2aSkiHPJvJ/jtwoPWjDjGJ4MT5
	hL4gCzj4PCbyYNJcPiH+72TYVX0PwCFncQ7rWWirghFB+qDzrpXaX+ZP0HySmI2nygoY+/
	BhfHJauwIR023Slt4qoiMC1jR0eRevQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-vx9CWUd9OFO_BpTkPc2xtA-1; Tue, 17 Jun 2025 10:39:32 -0400
X-MC-Unique: vx9CWUd9OFO_BpTkPc2xtA-1
X-Mimecast-MFC-AGG-ID: vx9CWUd9OFO_BpTkPc2xtA_1750171172
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451dda846a0so45355805e9.2
        for <linux-hyperv@vger.kernel.org>; Tue, 17 Jun 2025 07:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750171171; x=1750775971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPUJBR9Qf9kVxYZQYZ6+G9JwWB7GoNLWWQDEXWeJq2c=;
        b=BAVHM+3Kc7+lACIYhnEnzOs6MOqiXID7+l+w5GcLzkupPQXpHeLIZClradZx6y9rR7
         2CKgfOaId0zp14r4ozDhe4A5ZuTKUR5nzyILe1iVD8GvUoVZ8uKotM0PR3D1rYg7fle4
         aif+AMiYM39eCA3sCyVT11qmQQKvvsnrmeCpbg983teYHL7hWcP7i81NSMkVv9xIsLFr
         Ghm+8Um8mwR1WAZaLnW8pUzPJyp0owhtbMzFY0xgQgoy7NZ5eyPnY1BGY2Ek/KFS027T
         WVaaQz/TEPnx1Lt9UtkfPcE+JMSSGc7+Y6v9/235uVHbnEra/+aqMOI/WxVyAqpXkcRG
         aQjw==
X-Forwarded-Encrypted: i=1; AJvYcCUSj+u4bXmQhURrPRyFvjp/VYQpOoscsYKJJ3UJwLyufCMmG1TJOdgfdb3WjJ8r6Y1rlk3I6BHOXM/Tpco=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOaxtaHAkZRJmLgrwu+DMaLn46Q1O5451HNeBm+Mddu+NVIx7Y
	SMCwhmRVLDaVlZpwYhJXE70nPoRBYJ0Ayt31ui5toc0tELVaiLulvgdyyc9Uc/5iwZcbH8ZhJiu
	JRaM2Z0v8fSpMh7EkZnWJvpiQS21NztXXPMxouPO5mfpXBuapq2QqT5TFXiBFVfByBA==
X-Gm-Gg: ASbGncvxzs20N75/t/IDeS2TUFnURWTd8kN0438q1cBDYbyWvFKW8nKwkhOnN5+SPxS
	YKXSF6l1rJkG7kFsk9WOiJ/q7POpUpjxP6TOsfq+LPaq92u+3G3JFLURB8V9Qc/NsTQnHUC/pyF
	n7k5QFTzLmRiUtJuCGYHcTVljcqP2uMS65lssHvY1qS4TNLJgM5K7kR6Rui17fU/1t4VPu726z7
	R+A84PwcOiUmAMuBvAlwSkeuiOWt9PcnzgcYj5upiK5iMdZhndKQBAfGx0Nqja7fSmW6qM3KHn3
	teVvxcAo6iRodEqP8N5oErWeKrDH
X-Received: by 2002:a05:600d:13:b0:453:c39:d0c6 with SMTP id 5b1f17b1804b1-45344d8f6d6mr71096305e9.32.1750171171559;
        Tue, 17 Jun 2025 07:39:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNxFUr/RsjSCEdxIvQ1nYZxg2/GHtiJcbK0+y2FBpHGRW3fR6k2TfEm1PQ2vYeyp/yl4Cmrg==
X-Received: by 2002:a05:600d:13:b0:453:c39:d0c6 with SMTP id 5b1f17b1804b1-45344d8f6d6mr71095955e9.32.1750171171029;
        Tue, 17 Jun 2025 07:39:31 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.200.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e241b70sm175740145e9.18.2025.06.17.07.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:39:30 -0700 (PDT)
Date: Tue, 17 Jun 2025 16:39:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org
Cc: mst@redhat.com, pabeni@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, netdev@vger.kernel.org, stefanha@redhat.com, 
	leonardi@redhat.com, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, fupan.lfp@antgroup.com, Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [PATCH net-next v3 1/3] vsock: Add support for SIOCINQ ioctl
Message-ID: <y465uw5phymt3gbgdxsxlopeyhcbbherjri6b6etl64qhsc4ud@vc2c45mo5zxw>
References: <20250617045347.1233128-1-niuxuewei.nxw@antgroup.com>
 <20250617045347.1233128-2-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250617045347.1233128-2-niuxuewei.nxw@antgroup.com>

CCin hyper-v maintainers and list since I have a question about hyperv 
transport.

On Tue, Jun 17, 2025 at 12:53:44PM +0800, Xuewei Niu wrote:
>Add support for SIOCINQ ioctl, indicating the length of bytes unread in the
>socket. The value is obtained from `vsock_stream_has_data()`.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++++++++
> 1 file changed, 22 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 2e7a3034e965..bae6b89bb5fb 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1389,6 +1389,28 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
> 	vsk = vsock_sk(sk);
>
> 	switch (cmd) {
>+	case SIOCINQ: {
>+		ssize_t n_bytes;
>+
>+		if (!vsk->transport) {
>+			ret = -EOPNOTSUPP;
>+			break;
>+		}
>+
>+		if (sock_type_connectible(sk->sk_type) &&
>+		    sk->sk_state == TCP_LISTEN) {
>+			ret = -EINVAL;
>+			break;
>+		}
>+
>+		n_bytes = vsock_stream_has_data(vsk);

Now looks better to me, I just checked transports: vmci and virtio/vhost 
returns what we want, but for hyperv we have:

	static s64 hvs_stream_has_data(struct vsock_sock *vsk)
	{
		struct hvsock *hvs = vsk->trans;
		s64 ret;

		if (hvs->recv_data_len > 0)
			return 1;

@Hyper-v maintainers: do you know why we don't return `recv_data_len`?
Do you think we can do that to support this new feature?

Thanks,
Stefano

>+		if (n_bytes < 0) {
>+			ret = n_bytes;
>+			break;
>+		}
>+		ret = put_user(n_bytes, arg);
>+		break;
>+	}
> 	case SIOCOUTQ: {
> 		ssize_t n_bytes;
>
>-- 
>2.34.1
>



Return-Path: <linux-hyperv+bounces-9685-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLwFKmh8vmm8QwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-9685-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Mar 2026 12:09:28 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7CB2E4F69
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Mar 2026 12:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B74A309F0AC
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Mar 2026 11:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EE336C0AC;
	Sat, 21 Mar 2026 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="nj4nMsJS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC31285072;
	Sat, 21 Mar 2026 11:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774090814; cv=none; b=ZzTArVqivjwWGq5rt/+HYRMH/OwOX5jtp+fGKuyoRd8Vh89gfq6ENEWUGcFgUJTQlXXQpYYgUbFGh4ZKF64CiHNeaXeFGkoVWGKjLmpWdScplwdmQFZluZSACjR9vOdK+Wp5fp6CwKKsjUGt0tXMQ+zdfuuygIZ8KiL2vDemXVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774090814; c=relaxed/simple;
	bh=xon1nQweq732r5eVjdzZPB8zk5bI5qxbeUMD6cnUjpI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dra199Ff6wstrap9LM7iJPI5jdppV2123KOomGrnLvfxxi/EO5u5DOah9QHgucHnn3pgI9LtGs7G6vkJVhfH6h9clTjCJT6nX9qHJAZadumy8Qrabn71t94jTFp2/ad1n+aXt+UDG9Dh7AQrJGhmwnV8n/1V9XDW/d9SnaqDzfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=nj4nMsJS; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1774090685;
	bh=EBO7V58A7ssXU+gGEAK7HArbYDe3Nmo4Y/R/Js/t75A=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=nj4nMsJSZXdqOerzyCOm3L7nAoJkeTSas4XWThfr6tv4h6pXw2lN+HV+Cp5to6cy9
	 0OYaPGomTg8PLfqySDZVAvtDPDB9k6RelebjPZ+SjyOufLJsO2i60T1aE0GPK4X89x
	 Oiob0aQjnNckqLkqHgss378pT3riyzyZFAPUJXV0=
X-QQ-mid: zesmtpgz8t1774090677t17b96e5e
X-QQ-Originating-IP: Xon+mhcmBEE+Lcwhvqo98f/FbKlKhm3fP0ir12d4KSI=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 21 Mar 2026 18:57:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 101290449306167147
EX-QQ-RecipientCnt: 20
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	sgarzare@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	kexinsun@smail.nju.edu.cn,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg
Subject: [PATCH] hv_sock: update outdated comment for renamed vsock_stream_recvmsg()
Date: Sat, 21 Mar 2026 18:57:53 +0800
Message-Id: <20260321105753.6751-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: NBkE/PP8DpFY9NRetunQVCP6iiO9/Ub4XwlB/WqgpQceHWRlJBZYHw96
	8d5uhMllzOKAbRKGxUqm9XfA1EoEaN3AlvIR/Tk7FmwiY2g4ZBvD00QPRDHfNBYzokcs/hh
	7Ja03GJkjoTD/DzW8nmZbfdXurR+ZtYdhvsYqsTCOOZSWCeydYjoLKngKb8VsCzLBWfyYE/
	2vvBVN+Cwgn/AkGuvHleYj8CZpsrWttnM/I4EYv161IEj531RKxZS5LBm0xOLQiviM1C1mb
	Q/wL4tG5u4tvX4at61lAp/ckkHfLNUB7LnvB1HF2Du9BjvcelX/t61ioUp/uV0O50CLwD4f
	MgOwjmCi5Uoo+oTisB/SWwry9MNlNi3yo3rPGv4YbTgmtU+6EJLt3/s8iWB8+jbk0RnOjML
	sdiOibDX6ROmVeSnllX6HAxv/lHmKAyPIbE4ADBrAbxbblLX5v5cBC+8ssyoiRe+vS3ad1S
	frwqZkJILwt8jnYWMsJ2FulFNmj8Sk0VcfYDt2j9FGOR6UQOeHuHGt1Qw2e8zzKn7CALzEh
	/3RyQ9si+y8UZWtR6bVuQ2VfzT6dkW0UwFvz+b1Hd88TpvINeUJh9Jn57QVSwvTYNH7vUTf
	utuQDv/UlmqTi5mTs44DwazieuIR7fWnM+rQkJNey9COrjgQD/yhqticQbng53rZJwm5kCT
	KWqShksqCVy/kF0Gfwi516HpZWoxtbWQDfIb9ld1OSEsxtgQfMl6gA5QmvuSQdMXx8zSzom
	5a+Oq1bYASyCoEQFX65709thLIPTC7Hqh0eHgzRnmGPS3f5BE5dAdCPayKtJ6fMBDoyPQzN
	gxuHGOm0l7yvaxhkFwInllLMC9b3B+obOkJqbq2As1PZlAEd2QKou3D3+2GhtrnosSeqJC9
	sYRmmmOToSfq78S52WiVag+r+pul8b5QU23UzHPUCbjEvR3SFgRi7P9a7lhvtec3RIuEVbB
	6Y5zkrx48F5JcN7ZtDJlNiZK5+bhySldBzc+Vh5SnoTQXz3+ZO4ek9e8wLMkS7PasZ1415P
	t2p0jhtCLlFcrLNxT711OPaXQeucSen742QankR/VW7q/VlOTt75i9sCW3PuiI1rYR7r7N4
	McKBCrZVcQ0803c1rEN2NI=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[smail.nju.edu.cn,reject];
	R_DKIM_ALLOW(-0.20)[smail.nju.edu.cn:s=iohv2404];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9685-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[smail.nju.edu.cn:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_NEQ_ENVFROM(0.00)[kexinsun@smail.nju.edu.cn,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nju.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smail.nju.edu.cn:dkim,smail.nju.edu.cn:mid]
X-Rspamd-Queue-Id: 0C7CB2E4F69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The function vsock_stream_recvmsg() was renamed to
vsock_connectible_recvmsg() by commit a9e29e5511b9 ("af_vsock:
update functions for connectible socket").  Update the comment
accordingly.

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 net/vmw_vsock/hyperv_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 069386a74557..2b7c0b5896ed 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -196,7 +196,7 @@ static int hvs_channel_readable_payload(struct vmbus_channel *chan)
 
 	if (readable > HVS_PKT_LEN(0)) {
 		/* At least we have 1 byte to read. We don't need to return
-		 * the exact readable bytes: see vsock_stream_recvmsg() ->
+		 * the exact readable bytes: see vsock_connectible_recvmsg() ->
 		 * vsock_stream_has_data().
 		 */
 		return 1;
-- 
2.25.1


